package trungduc.vn.controllers.web;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import trungduc.vn.entity.Product;
import trungduc.vn.services.IProductService;
import trungduc.vn.services.impl.ProductServiceImpl;

@WebServlet(urlPatterns = {"/product", "/product/detail"})
public class ProductWebController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private static final int PAGE_SIZE = 6; // 6 sản phẩm mỗi trang theo yêu cầu

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();

        // 1. Xem chi tiết sản phẩm
        if (uri.contains("/product/detail")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                int id = Integer.parseInt(idStr.trim());
                Product product = productService.findById(id);
                req.setAttribute("product", product);
            }
            req.getRequestDispatcher("/views/web/product-detail.jsp").forward(req, resp);
            return;
        }

        // 2. Hiển thị tất cả sản phẩm phân trang 6 sp/trang tại URL /product
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageStr.trim());
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int totalProducts = productService.countAll();
        int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Product> list = productService.findPaginated(page, PAGE_SIZE);

        req.setAttribute("listProducts", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalProducts", totalProducts);

        req.getRequestDispatcher("/views/web/product-list.jsp").forward(req, resp);
    }
}