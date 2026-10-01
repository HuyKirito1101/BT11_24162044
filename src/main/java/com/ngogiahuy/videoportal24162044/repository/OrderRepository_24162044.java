package com.ngogiahuy.videoportal24162044.repository;

import com.ngogiahuy.videoportal24162044.config.JpaUtil_24162044;
import com.ngogiahuy.videoportal24162044.entity.Order_24162044;
import jakarta.persistence.EntityManager;
import java.util.List;

public class OrderRepository_24162044 {

    public void save(Order_24162044 order) {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            try {
                em.getTransaction().begin();
                if (order.getOrderId() == null) {
                    em.persist(order);
                } else {
                    em.merge(order);
                }
                em.getTransaction().commit();
            } catch (RuntimeException e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw e;
            }
        }
    }

    public Order_24162044 findById(Integer orderId) {
        if (orderId == null || orderId <= 0) return null;
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            List<Order_24162044> list = em.createQuery(
                    "SELECT DISTINCT o FROM Order_24162044 o " +
                    "LEFT JOIN FETCH o.details d " +
                    "LEFT JOIN FETCH d.video v " +
                    "WHERE o.orderId = :id", Order_24162044.class)
                    .setParameter("id", orderId)
                    .getResultList();
            return list.isEmpty() ? null : list.getFirst();
        }
    }

    public List<Order_24162044> findByUsername(String username) {
        if (username == null || username.isBlank()) return List.of();
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            return em.createQuery(
                    "SELECT DISTINCT o FROM Order_24162044 o " +
                    "LEFT JOIN FETCH o.details d " +
                    "LEFT JOIN FETCH d.video v " +
                    "WHERE o.user.username = :username " +
                    "ORDER BY o.orderDate DESC", Order_24162044.class)
                    .setParameter("username", username)
                    .getResultList();
        }
    }

    public List<Order_24162044> findAll() {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            return em.createQuery(
                    "SELECT DISTINCT o FROM Order_24162044 o " +
                    "LEFT JOIN FETCH o.details d " +
                    "LEFT JOIN FETCH d.video v " +
                    "ORDER BY o.orderDate DESC", Order_24162044.class)
                    .getResultList();
        }
    }
}
