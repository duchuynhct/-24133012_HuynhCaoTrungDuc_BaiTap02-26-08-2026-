package trungduc.vn.controllers.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import trungduc.vn.entity.Category;
import trungduc.vn.entity.Product;
import trungduc.vn.services.ICategoryService;
import trungduc.vn.services.IProductService;
import trungduc.vn.services.impl.CategoryServiceImpl;
import trungduc.vn.services.impl.ProductServiceImpl;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/add",
    "/admin/product/insert",
    "/admin/product/edit",
    "/admin/product/update",
    "/admin/product/delete"
})
public class ProductAdminController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();
    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();

        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("listProducts", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/delete")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String url = req.getRequestURI();
        String uploadPath = req.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (url.contains("/admin/product/insert")) {
            String productName = req.getParameter("productname");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String categoryIdStr = req.getParameter("categoryid");
            String statusStr = req.getParameter("status");

            // Server-side validation
            if (productName == null || productName.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                quantityStr == null || quantityStr.trim().isEmpty() ||
                categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập đầy đủ các trường thông tin bắt buộc!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            if (productName.trim().length() < 3) {
                req.setAttribute("error", "Tên sản phẩm phải có ít nhất 3 ký tự!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            double price;
            int quantity;
            int categoryId;
            int status = 1;
            try {
                price = Double.parseDouble(priceStr);
                quantity = Integer.parseInt(quantityStr);
                categoryId = Integer.parseInt(categoryIdStr);
                if (statusStr != null) status = Integer.parseInt(statusStr);
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Giá bán hoặc số lượng không đúng định dạng số hợp lệ!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            if (price <= 0) {
                req.setAttribute("error", "Giá bán sản phẩm phải lớn hơn 0 VNĐ!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            if (quantity < 0) {
                req.setAttribute("error", "Số lượng sản phẩm tồn kho không được âm!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            Category category = categoryService.findById(categoryId);
            if (category == null) {
                req.setAttribute("error", "Danh mục đã chọn không tồn tại trong hệ thống!");
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            // Xử lý upload ảnh an toàn
            String finalFileName = "";
            try {
                Part filePart = req.getPart("images");
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedName = filePart.getSubmittedFileName();
                    if (submittedName != null && !submittedName.trim().isEmpty()) {
                        String lower = submittedName.toLowerCase();
                        if (!lower.endsWith(".jpg") && !lower.endsWith(".jpeg") && !lower.endsWith(".png") && !lower.endsWith(".webp") && !lower.endsWith(".gif")) {
                            req.setAttribute("error", "Ảnh sản phẩm phải có định dạng JPG, JPEG, PNG, WEBP hoặc GIF!");
                            req.setAttribute("categories", categoryService.findAll());
                            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                            return;
                        }
                        String fileName = Paths.get(submittedName).getFileName().toString();
                        finalFileName = System.currentTimeMillis() + "_" + fileName;
                        filePart.write(uploadPath + File.separator + finalFileName);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            Product product = new Product();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setImages(finalFileName);
            product.setStatus(status);
            product.setCreateDate(LocalDateTime.now());
            product.setCategory(category);

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if (url.contains("/admin/product/update")) {
            int id = Integer.parseInt(req.getParameter("productid"));
            String productName = req.getParameter("productname");
            String description = req.getParameter("description");
            String priceStr = req.getParameter("price");
            String quantityStr = req.getParameter("quantity");
            String categoryIdStr = req.getParameter("categoryid");
            String statusStr = req.getParameter("status");
            String oldImage = req.getParameter("oldImage");

            Product currentProduct = productService.findById(id);

            // Server-side validation
            if (productName == null || productName.trim().isEmpty() ||
                priceStr == null || priceStr.trim().isEmpty() ||
                quantityStr == null || quantityStr.trim().isEmpty() ||
                categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                req.setAttribute("error", "Vui lòng nhập đầy đủ các trường thông tin bắt buộc!");
                req.setAttribute("product", currentProduct);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            if (productName.trim().length() < 3) {
                req.setAttribute("error", "Tên sản phẩm phải có ít nhất 3 ký tự!");
                req.setAttribute("product", currentProduct);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            double price;
            int quantity;
            int categoryId;
            int status = 1;
            try {
                price = Double.parseDouble(priceStr);
                quantity = Integer.parseInt(quantityStr);
                categoryId = Integer.parseInt(categoryIdStr);
                if (statusStr != null) status = Integer.parseInt(statusStr);
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Giá bán hoặc số lượng không đúng định dạng số hợp lệ!");
                req.setAttribute("product", currentProduct);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            if (price <= 0) {
                req.setAttribute("error", "Giá bán sản phẩm phải lớn hơn 0 VNĐ!");
                req.setAttribute("product", currentProduct);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            if (quantity < 0) {
                req.setAttribute("error", "Số lượng sản phẩm tồn kho không được âm!");
                req.setAttribute("product", currentProduct);
                req.setAttribute("categories", categoryService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            Category category = categoryService.findById(categoryId);

            // Xử lý upload ảnh mới nếu có chọn
            String finalFileName = oldImage;
            try {
                Part filePart = req.getPart("images");
                if (filePart != null && filePart.getSize() > 0) {
                    String submittedName = filePart.getSubmittedFileName();
                    if (submittedName != null && !submittedName.trim().isEmpty()) {
                        String lower = submittedName.toLowerCase();
                        if (!lower.endsWith(".jpg") && !lower.endsWith(".jpeg") && !lower.endsWith(".png") && !lower.endsWith(".webp") && !lower.endsWith(".gif")) {
                            req.setAttribute("error", "Ảnh sản phẩm phải có định dạng JPG, JPEG, PNG, WEBP hoặc GIF!");
                            req.setAttribute("product", currentProduct);
                            req.setAttribute("categories", categoryService.findAll());
                            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                            return;
                        }
                        String fileName = Paths.get(submittedName).getFileName().toString();
                        finalFileName = System.currentTimeMillis() + "_" + fileName;
                        filePart.write(uploadPath + File.separator + finalFileName);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (currentProduct != null) {
                currentProduct.setProductName(productName.trim());
                currentProduct.setDescription(description != null ? description.trim() : "");
                currentProduct.setPrice(price);
                currentProduct.setQuantity(quantity);
                currentProduct.setImages(finalFileName);
                currentProduct.setStatus(status);
                currentProduct.setCategory(category);
                productService.update(currentProduct);
            }

            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}