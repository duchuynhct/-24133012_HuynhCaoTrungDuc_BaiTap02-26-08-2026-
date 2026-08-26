package trungduc.vn.dao.impl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import trungduc.vn.configs.JpaConfig;
import trungduc.vn.dao.ICategoryDao;
import trungduc.vn.entity.Category;

public class CategoryDaoImpl implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(category); // Thêm mới
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(category); // Cập nhật
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public void delete(int categoryId) throws Exception {
        EntityManager em = JpaConfig.getEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Category category = em.find(Category.class, categoryId);
            if (category != null) {
                em.remove(category); // Xóa
            } else {
                throw new Exception("Không tìm thấy danh mục để xóa!");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public Category findById(int categoryId) {
        EntityManager em = JpaConfig.getEntityManager();
        Category category = em.find(Category.class, categoryId);
        em.close();
        return category;
    }

    @Override
    public List<Category> findAll() {
        EntityManager em = JpaConfig.getEntityManager();
        // Gọi NamedQuery đã khai báo ở entity @NamedQuery(name = "Category.findAll", ...)
        TypedQuery<Category> query = em.createNamedQuery("Category.findAll", Category.class);
        List<Category> list = query.getResultList();
        em.close();
        return list;
    }
}