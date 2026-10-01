package com.ngogiahuy.videoportal24162044.entity;

public enum OrderStatus_24162044 {
    NEW("NEW", "Đơn hàng mới", "badge-new"),
    CONFIRMED("CONFIRMED", "Đã xác nhận", "badge-confirmed"),
    PREPARING("PREPARING", "Chuẩn bị hàng", "badge-preparing"),
    SHIPPING("SHIPPING", "Vận chuyển", "badge-shipping"),
    DELIVERING("DELIVERING", "Giao hàng", "badge-delivering"),
    DELIVERED("DELIVERED", "Đã giao", "badge-delivered"),
    CANCELLED("CANCELLED", "Đơn hàng hủy", "badge-cancelled"),
    RETURNED("RETURNED", "Đơn hàng hoàn", "badge-returned");

    private final String code;
    private final String displayName;
    private final String badgeClass;

    OrderStatus_24162044(String code, String displayName, String badgeClass) {
        this.code = code;
        this.displayName = displayName;
        this.badgeClass = badgeClass;
    }

    public String getCode() { return code; }
    public String getDisplayName() { return displayName; }
    public String getBadgeClass() { return badgeClass; }

    /**
     * Parses any status string (code, English, or Vietnamese text from database).
     */
    public static OrderStatus_24162044 from(String raw) {
        if (raw == null || raw.isBlank()) return NEW;
        String s = raw.trim().toUpperCase().replace("-", "_").replace(" ", "_");

        for (OrderStatus_24162044 st : values()) {
            if (st.name().equalsIgnoreCase(s) || st.code.equalsIgnoreCase(s)) {
                return st;
            }
        }

        String clean = raw.trim().toLowerCase();
        if (clean.contains("mới") || clean.contains("moi") || clean.contains("pending") || clean.contains("new")) {
            return NEW;
        }
        if (clean.contains("xác nhận") || clean.contains("xac nhan") || clean.contains("confirmed")) {
            return CONFIRMED;
        }
        if (clean.contains("chuẩn bị") || clean.contains("chuan bi") || clean.contains("preparing") || clean.contains("processing")) {
            return PREPARING;
        }
        if (clean.contains("vận chuyển") || clean.contains("van chuyen") || clean.contains("vận chuyện") || clean.contains("van chuyen") || clean.contains("shipping") || clean.contains("transit")) {
            return SHIPPING;
        }
        if (clean.contains("giao hàng") || clean.contains("giao hang") || clean.contains("delivering")) {
            return DELIVERING;
        }
        if (clean.contains("đã giao") || clean.contains("da giao") || clean.contains("delivered") || clean.contains("completed") || clean.contains("hoàn thành")) {
            return DELIVERED;
        }
        if (clean.contains("hủy") || clean.contains("huy") || clean.contains("cancel")) {
            return CANCELLED;
        }
        if (clean.contains("hoàn") || clean.contains("hoan") || clean.contains("return") || clean.contains("trả") || clean.contains("tra")) {
            return RETURNED;
        }

        return NEW;
    }

    public boolean matches(String rawStatus) {
        return this == from(rawStatus);
    }
}
