package trungduc.vn.test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import trungduc.vn.configs.JpaConfig;
import trungduc.vn.entity.User;

public class InitAdminAccount {

    public static void main(String[] args) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();

        try {
            trans.begin();

            User admin = em.find(User.class, "admin");
            if (admin == null) {
                admin = new User();
                admin.setUsername("admin");
                admin.setPassword("123456");
                admin.setEmail("admin@gmail.com");
                admin.setFullname("Quản Trị Viên (Admin)");
                admin.setPhone("0912345678");
                admin.setRoleid(1); // 1: Admin
                admin.setStatus(1); // 1: Active
                em.persist(admin);
                System.out.println(">>> ĐÃ TẠO MỚI TÀI KHOẢN ADMIN THÀNH CÔNG! <<<");
            } else {
                admin.setPassword("123456");
                admin.setFullname("Quản Trị Viên (Admin)");
                admin.setPhone("0912345678");
                admin.setRoleid(1);
                admin.setStatus(1);
                em.merge(admin);
                System.out.println(">>> ĐÃ CẬP NHẬT TÀI KHOẢN ADMIN HIỆN CÓ THÀNH CÔNG! <<<");
            }

            trans.commit();

            System.out.println("Thông tin tài khoản Admin:");
            System.out.println("- Username: admin");
            System.out.println("- Password: 123456");
            System.out.println("- Role: Admin (roleid=1)");
            System.out.println("- Status: Đã kích hoạt (status=1)");
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
            JpaConfig.shutdown();
        }
    }
}

