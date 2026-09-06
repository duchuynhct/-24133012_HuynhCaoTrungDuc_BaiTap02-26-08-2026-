package trungduc.vn.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

@Entity
@Table(name = "products")
@NamedQueries({
    @NamedQuery(name = "Product.findAll", query = "SELECT p FROM Product p ORDER BY p.productId DESC"),
    @NamedQuery(name = "Product.findTop10Latest", query = "SELECT p FROM Product p ORDER BY p.createDate DESC"),
    @NamedQuery(name = "Product.countAll", query = "SELECT COUNT(p) FROM Product p")
})
public class Product implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "productId")
    private int productId;

    @Column(name = "productName", columnDefinition = "nvarchar(200) not null")
    private String productName;

    @Column(name = "description", columnDefinition = "nvarchar(MAX) null")
    private String description;

    @Column(name = "price")
    private double price;

    @Column(name = "quantity")
    private int quantity;

    @Column(name = "images", columnDefinition = "nvarchar(500) null")
    private String images;

    @Column(name = "status")
    private int status; // 1: Hoat dong (Con hang), 0: Tam khoa (Het hang)

    @Column(name = "createDate")
    private LocalDateTime createDate;

    @ManyToOne
    @JoinColumn(name = "categoryId")
    private Category category;

    public Product() {
        this.createDate = LocalDateTime.now();
        this.status = 1;
    }

    public Product(int productId, String productName, String description, double price, int quantity, String images,
                   int status, LocalDateTime createDate, Category category) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.images = images;
        this.status = status;
        this.createDate = createDate;
        this.category = category;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}