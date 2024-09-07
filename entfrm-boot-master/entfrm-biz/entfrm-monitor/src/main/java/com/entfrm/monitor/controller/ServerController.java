package com.entfrm.monitor.controller;

import com.entfrm.base.constant.AppConstants;
import com.entfrm.monitor.server.Server;
import com.entfrm.base.api.R;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 服务器监控
 *
 * @author yong
 */
@RestController
@RequestMapping(AppConstants.APP_MONITOR + "/server")
public class ServerController {

    @GetMapping()
    public R getInfo() throws Exception {
        Server server = new Server();
        server.copyTo();
        return R.ok(server);
    }
}
