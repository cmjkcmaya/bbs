package com.wzn.bysj.bbs.shiro;

import com.wzn.bysj.bbs.entity.User;
import com.wzn.bysj.bbs.mapper.PermissionMapper;
import com.wzn.bysj.bbs.service.ForbidService;
import com.wzn.bysj.bbs.service.PermissionService;
import com.wzn.bysj.bbs.service.UserService;
import com.wzn.bysj.bbs.util.UserUtil;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Set;

public class MyRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;
    @Autowired
    private PermissionService permissionService;

    @Autowired
    private ForbidService forbidService;
    @Autowired
    private SessionDAO sessionDAO;
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        //能进入到这里，表示账号已经通过验证了
        String userName =(String) principalCollection.getPrimaryPrincipal();
        //通过service获取角色和权限
        Set<String> permissions = permissionService.listPermissionsByUserName(userName);

        //授权对象
        SimpleAuthorizationInfo s = new SimpleAuthorizationInfo();

       s.setStringPermissions(permissions);
        return s;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //获取账号密码
        UsernamePasswordToken t = (UsernamePasswordToken) token;
        String userName= token.getPrincipal().toString();
        String password= new String( t.getPassword());
        //获取数据库中的密码
        String passwordInDB = userService.getPassword(userName);
        User u=userService.getUserByUserName(userName);
        //如果为空就是账号不存在，如果不相同就是密码错误
        if(null==passwordInDB ) {
            throw new AuthenticationException("该用户不存在！");
        }
        if(!passwordInDB.equals(password)){
            throw new AuthenticationException("密码错误！");
        }
if(u.getBlock()==1){
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String s = sdf.format(forbidService.getFtime(u.getId()));
    throw new AuthenticationException("该账号被封禁到"+s);
}

        Collection<Session> sessions = sessionDAO.getActiveSessions();//DAO(Data Access Object) 数据访问对象   MemorySessionDAO 直接在内存中进行会话维护
        System.out.println(sessions.size());
        for (Session session : sessions) {
//当用户登录成功后，shiro会把用户名放到session的attribute中，key为DefaultSubjectContext.PRINCIPALS_SESSION_KEY，
            if (userName.equals(String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)))) {
                session.setTimeout(0);// 设置session立即失效，即将其踢出系统
                break;
            }
        }

        //认证信息里存放账号密码, getName() 是当前Realm的继承方法,通常返回当前类名
        SimpleAuthenticationInfo a = new SimpleAuthenticationInfo(userName,password,getName());
        return a;
    }

}
