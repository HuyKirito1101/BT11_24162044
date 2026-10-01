package com.ngogiahuy.videoportal24162044.config;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class JpaLifecycleListener_24162044 implements ServletContextListener {
    @Override
    public void contextDestroyed(ServletContextEvent event) { JpaUtil_24162044.close(); }
}
