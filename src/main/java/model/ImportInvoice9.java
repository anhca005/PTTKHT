package model;

import java.util.Date;
import java.util.ArrayList;

public class ImportInvoice9 implements java.io.Serializable {
    private int id;
    private Date importDate;
    private float totalAmount;
    private String note;
    private Supplier9 supplier;
    private Librarian9 librarian;
    private ArrayList<ImportedDocument9> importedDocuments;

    public ImportInvoice9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public float getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Supplier9 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier9 supplier) {
        this.supplier = supplier;
    }

    public Librarian9 getLibrarian() {
        return librarian;
    }

    public void setLibrarian(Librarian9 librarian) {
        this.librarian = librarian;
    }

    public ArrayList<ImportedDocument9> getImportedDocuments() {
        return importedDocuments;
    }

    public void setImportedDocuments(ArrayList<ImportedDocument9> importedDocuments) {
        this.importedDocuments = importedDocuments;
    }
}
