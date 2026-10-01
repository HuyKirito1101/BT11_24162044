package com.ngogiahuy.videoportal24162044.service;

import java.util.List;

public class PagedResult_24162044<T> {
    private final List<T> items; private final int page; private final int totalPages; private final long totalItems;
    public PagedResult_24162044(List<T> items, int page, int pageSize, long totalItems) { this.items=items; this.page=page; this.totalItems=totalItems; this.totalPages=Math.max(1,(int)Math.ceil((double)totalItems/pageSize)); }
    public List<T> getItems(){return items;} public int getPage(){return page;} public int getTotalPages(){return totalPages;} public long getTotalItems(){return totalItems;}
}
