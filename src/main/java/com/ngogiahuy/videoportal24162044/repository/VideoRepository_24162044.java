package com.ngogiahuy.videoportal24162044.repository;

import com.ngogiahuy.videoportal24162044.config.JpaUtil_24162044;
import com.ngogiahuy.videoportal24162044.entity.Favorite_24162044;
import com.ngogiahuy.videoportal24162044.entity.Share_24162044;
import com.ngogiahuy.videoportal24162044.entity.User_24162044;
import com.ngogiahuy.videoportal24162044.entity.Video_24162044;
import jakarta.persistence.EntityManager;
import java.util.List;

public class VideoRepository_24162044 {
    private static final String BASE = "SELECT v FROM Video_24162044 v LEFT JOIN FETCH v.category ";
    private static final String PUBLIC = "v.active=true AND v.category.status=true ";

    public List<Video_24162044> findPage(int page, int size) {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            List<Video_24162044> videos = em.createQuery(BASE + "ORDER BY v.videoId ASC", Video_24162044.class)
                    .setFirstResult((page - 1) * size).setMaxResults(size).getResultList();
            loadStatistics(em, videos);
            return videos;
        }
    }

    public List<Video_24162044> findByCategoryPage(Integer categoryId, int page, int size) {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            List<Video_24162044> videos = em.createQuery(BASE + "WHERE " + PUBLIC
                            + "AND v.category.categoryId=:id ORDER BY v.videoId ASC", Video_24162044.class)
                    .setParameter("id", categoryId).setFirstResult((page - 1) * size)
                    .setMaxResults(size).getResultList();
            loadStatistics(em, videos);
            return videos;
        }
    }

    public long countAll() {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            return em.createQuery("SELECT COUNT(v) FROM Video_24162044 v", Long.class).getSingleResult();
        }
    }

    public long countByCategory(Integer categoryId) {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            return em.createQuery("SELECT COUNT(v) FROM Video_24162044 v WHERE " + PUBLIC
                            + "AND v.category.categoryId=:id", Long.class)
                    .setParameter("id", categoryId).getSingleResult();
        }
    }

    public Video_24162044 findById(Integer id) {
        if (id == null || id <= 0) return null;
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            List<Video_24162044> videos = em.createQuery(BASE + "WHERE v.videoId=:id", Video_24162044.class)
                    .setParameter("id", id).getResultList();
            loadStatistics(em, videos);
            return videos.isEmpty() ? null : videos.getFirst();
        }
    }

    public void incrementViews(Integer id) {
        if (id == null || id <= 0) return;
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            try {
                em.getTransaction().begin();
                em.createQuery("UPDATE Video_24162044 v SET v.views = v.views + 1 WHERE v.videoId = :id")
                        .setParameter("id", id).executeUpdate();
                em.getTransaction().commit();
            } catch (RuntimeException e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw e;
            }
        }
    }

    public boolean isLikedByUser(Integer videoId, String username) {
        if (videoId == null || username == null || username.isBlank()) return false;
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            Long count = em.createQuery("SELECT COUNT(f) FROM Favorite_24162044 f WHERE f.video.videoId = :vId AND f.user.username = :uName", Long.class)
                    .setParameter("vId", videoId)
                    .setParameter("uName", username)
                    .getSingleResult();
            return count > 0;
        }
    }

    public boolean toggleLike(Integer videoId, String username) {
        if (videoId == null || username == null || username.isBlank()) return false;
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            try {
                em.getTransaction().begin();
                List<Favorite_24162044> list = em.createQuery("SELECT f FROM Favorite_24162044 f WHERE f.video.videoId = :vId AND f.user.username = :uName", Favorite_24162044.class)
                        .setParameter("vId", videoId)
                        .setParameter("uName", username)
                        .getResultList();
                boolean liked;
                if (!list.isEmpty()) {
                    for (Favorite_24162044 fav : list) em.remove(fav);
                    liked = false;
                } else {
                    Video_24162044 video = em.find(Video_24162044.class, videoId);
                    User_24162044 user = em.find(User_24162044.class, username);
                    if (video != null && user != null) {
                        Favorite_24162044 fav = new Favorite_24162044();
                        fav.setVideo(video);
                        fav.setUser(user);
                        fav.setLikedDate(java.time.LocalDate.now());
                        em.persist(fav);
                    }
                    liked = true;
                }
                em.getTransaction().commit();
                return liked;
            } catch (RuntimeException e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw e;
            }
        }
    }

    public void addShare(Integer videoId, String username, String email) {
        if (videoId == null || email == null || email.isBlank()) return;
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            try {
                em.getTransaction().begin();
                Video_24162044 video = em.find(Video_24162044.class, videoId);
                User_24162044 user = (username != null && !username.isBlank()) ? em.find(User_24162044.class, username) : null;
                if (video != null) {
                    Share_24162044 share = new Share_24162044();
                    share.setVideo(video);
                    share.setUser(user);
                    share.setEmails(email);
                    share.setSharedDate(java.time.LocalDate.now());
                    em.persist(share);
                }
                em.getTransaction().commit();
            } catch (RuntimeException e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw e;
            }
        }
    }

    private void loadStatistics(EntityManager em, List<Video_24162044> videos) {
        if (videos.isEmpty()) return;
        List<Integer> ids = videos.stream().map(Video_24162044::getVideoId).toList();
        for (String entity : List.of("Favorite_24162044", "Share_24162044")) {
            List<Object[]> counts = em.createQuery("SELECT x.video.videoId, COUNT(x) FROM " + entity
                    + " x WHERE x.video.videoId IN :ids GROUP BY x.video.videoId", Object[].class)
                    .setParameter("ids", ids).getResultList();
            for (Object[] count : counts) {
                videos.stream().filter(v -> v.getVideoId().equals(count[0])).forEach(v -> {
                    if (entity.startsWith("Favorite")) v.setLikeCount((Long) count[1]);
                    else v.setShareCount((Long) count[1]);
                });
            }
        }
    }

    public void save(Video_24162044 video) {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            try {
                em.getTransaction().begin();
                if (video.getVideoId() == null) em.persist(video); else em.merge(video);
                em.getTransaction().commit();
            } catch (RuntimeException e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw e;
            }
        }
    }

    public void delete(Integer id) {
        try (EntityManager em = JpaUtil_24162044.createEntityManager()) {
            try {
                em.getTransaction().begin();
                Video_24162044 video = em.find(Video_24162044.class, id);
                if (video != null) {
                    em.createQuery("DELETE FROM Favorite_24162044 f WHERE f.video.videoId=:id")
                            .setParameter("id", id).executeUpdate();
                    em.createQuery("DELETE FROM Share_24162044 s WHERE s.video.videoId=:id")
                            .setParameter("id", id).executeUpdate();
                    em.remove(video);
                }
                em.getTransaction().commit();
            } catch (RuntimeException e) {
                if (em.getTransaction().isActive()) em.getTransaction().rollback();
                throw e;
            }
        }
    }
}
