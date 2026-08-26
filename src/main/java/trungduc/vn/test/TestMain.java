package trungduc.vn.test;

import java.util.List;
import jakarta.persistence.EntityManager;
import trungduc.vn.configs.JpaConfig;
import trungduc.vn.entity.Category;
import trungduc.vn.entity.Video;

public class TestMain {

    public static void main(String[] args) {
        EntityManager em = JpaConfig.getEntityManager();

        try {
            List<Category> list = em.createNamedQuery("Category.findAll", Category.class).getResultList();

            System.out.println("========== DANH SÁCH DỮ LIỆU ==========");
            for (Category c : list) {
                System.out.println("Category [" + c.getCategoryid() + "]: " + c.getCategoryname());
                for (Video v : c.getVideos()) {
                    System.out.println("  └── Video ID: " + v.getVideoId() + " | Title: " + v.getTitle());
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
            JpaConfig.shutdown();
        }
    }
}