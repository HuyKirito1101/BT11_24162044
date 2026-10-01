package com.ngogiahuy.videoportal24162044.repository;

import com.ngogiahuy.videoportal24162044.config.JpaUtil_24162044;
import com.ngogiahuy.videoportal24162044.entity.Category_24162044;
import jakarta.persistence.EntityManager;
import java.util.List;

public class CategoryRepository_24162044 {
    public List<Category_24162044> findAll() {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            return em.createQuery("SELECT c FROM Category_24162044 c ORDER BY c.categoryname", Category_24162044.class).getResultList();
        }
    }
    public List<Category_24162044> findActive() {
        EntityManager em = JpaUtil_24162044.createEntityManager();
        try { return em.createQuery("SELECT c FROM Category_24162044 c WHERE c.status = true ORDER BY c.categoryname", Category_24162044.class).getResultList(); } finally { em.close(); }
    }
    public Category_24162044 findById(Integer id) { EntityManager em=JpaUtil_24162044.createEntityManager(); try{return em.find(Category_24162044.class,id);}finally{em.close();} }
}
