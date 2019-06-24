package com.wzn.bysj.bbs.controller;

    import com.wzn.bysj.bbs.entity.Advise;
    import com.wzn.bysj.bbs.entity.Forbid;
    import com.wzn.bysj.bbs.entity.User;
    import com.wzn.bysj.bbs.service.AdviseService;
    import com.wzn.bysj.bbs.service.ForbidService;
    import com.wzn.bysj.bbs.service.UserService;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.context.annotation.Lazy;
    import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

    import java.util.Date;
    import java.util.List;


@Component
    public class TimerTask {

    @Autowired
    UserService userService;
    @Autowired
    ForbidService forbidService;

    @Autowired
    AdviseService adviseService;
        /**
         * 每天0点启动任务
         */
        @Scheduled(cron = "0 0 0 * * ?")
        public void test1()
        {
            System.out.println("定时任务执行");
            List<Forbid> f=forbidService.listjiejin();
            for(Forbid forbid:f){
            forbidService.deleteForbid(forbid.getFid());
                User u = forbid.getUser();
                Advise a=new Advise();
                if(forbid.getHandle()==2){
                    a.setContent("您被解除封禁。");
                u.setBlock(0);
                }else {
                    a.setContent("您被解除禁言。");
                    u.setForbid(0);
                }
                userService.updateUser(u);

                a.setRecer(u);
                a.setPtime(new Date());
                adviseService.saveAdvise(a);
            }
        }

    }


