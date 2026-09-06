package trungduc.vn.dao;

import java.util.List;
import trungduc.vn.entity.Product;

public interface IProductDao {

    void insert(Product product);

    void update(Product product);

    void delete(int productId) throws Exception;

    Product findById(int productId);

    List<Product> findAll();

    List<Product> findTop10Latest();

    List<Product> findPaginated(int page, int pageSize);

    int countAll();
}