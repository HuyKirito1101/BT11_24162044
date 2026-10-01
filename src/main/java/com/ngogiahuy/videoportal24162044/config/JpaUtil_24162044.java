package com.ngogiahuy.videoportal24162044.config;

import jakarta.persistence.*;
import java.util.HashMap;
import java.util.Map;

public final class JpaUtil_24162044 {
    private static EntityManagerFactory factory;
    private JpaUtil_24162044() { }

    public static synchronized EntityManager createEntityManager() {
        if (factory == null || !factory.isOpen()) {
            Map<String, Object> overrides = new HashMap<>();
            override(overrides, "url", "DB_URL");
            override(overrides, "user", "DB_USER");
            override(overrides, "password", "DB_PASSWORD");
            factory = Persistence.createEntityManagerFactory("VideoPortalPU", overrides);
        }
        return factory.createEntityManager();
    }

    private static void override(Map<String, Object> properties, String key, String env) {
        String value = System.getProperty("video.db." + key, System.getenv(env));
        if (value != null) properties.put("jakarta.persistence.jdbc." + key, value);
    }

    public static synchronized void close() {
        if (factory != null && factory.isOpen()) factory.close();
    }
}
