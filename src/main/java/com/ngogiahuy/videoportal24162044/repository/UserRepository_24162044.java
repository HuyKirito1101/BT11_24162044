package com.ngogiahuy.videoportal24162044.repository;

import com.ngogiahuy.videoportal24162044.config.JpaUtil_24162044;
import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import jakarta.persistence.EntityManager;

public class UserRepository_24162044 {
    public User_24162044 findByUsername(String username) {
        EntityManager em = JpaUtil_24162044.createEntityManager();
        try { return em.find(User_24162044.class, username); } finally { em.close(); }
    }
    public User_24162044 findByEmail(String email) {
        EntityManager em = JpaUtil_24162044.createEntityManager();
        try { return em.createQuery("SELECT u FROM User_24162044 u WHERE u.email = :email", User_24162044.class).setParameter("email", email).getResultStream().findFirst().orElse(null); } finally { em.close(); }
    }
    public boolean activate(String username, String otp) {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            try {
                em.getTransaction().begin();
                User_24162044 user = em.find(User_24162044.class, username, jakarta.persistence.LockModeType.PESSIMISTIC_WRITE);
                boolean valid = user != null && !user.isActive() && user.getOtpExpiresAt() != null
                        && user.getOtpExpiresAt().isAfter(java.time.LocalDateTime.now()) && otp.equals(user.getOtpCode());
                if (valid) {
                    user.setActive(true);
                    user.setOtpCode(null);
                    user.setOtpExpiresAt(null);
                }
                em.getTransaction().commit();
                return valid;
            } catch (RuntimeException e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw e;
            }
        }
    }
    public void save(User_24162044 user) {
        EntityManager em = JpaUtil_24162044.createEntityManager();
        try { em.getTransaction().begin(); if (em.find(User_24162044.class, user.getUsername()) == null) em.persist(user); else em.merge(user); em.getTransaction().commit(); }
        catch (RuntimeException e) { if (em.getTransaction().isActive()) em.getTransaction().rollback(); throw e; } finally { em.close(); }
    }
}
