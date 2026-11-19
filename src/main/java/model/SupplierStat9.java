package model;

public class SupplierStat9 extends Supplier9 {
    private int totalImportQuantity;
    private float totalImportAmount;

    public SupplierStat9() {
        super();
    }

    public int getTotalImportQuantity() {
        return totalImportQuantity;
    }

    public void setTotalImportQuantity(int totalImportQuantity) {
        this.totalImportQuantity = totalImportQuantity;
    }

    public float getTotalImportAmount() {
        return totalImportAmount;
    }

    public void setTotalImportAmount(float totalImportAmount) {
        this.totalImportAmount = totalImportAmount;
    }
}
