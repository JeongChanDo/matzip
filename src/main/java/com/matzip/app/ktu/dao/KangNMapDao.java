package com.matzip.app.ktu.dao;

import java.util.List;

import com.matzip.app.ktu.domain.MatZipBean;


public interface KangNMapDao {
	public List<MatZipBean> matZipList();
	public MatZipBean matZipHanSearch();
	public MatZipBean matZipChaSearch();
	public MatZipBean matZipBunSearch();
	public MatZipBean matZipJapSearch();
	public MatZipBean matZipEtcSearch();
	public MatZipBean matZipWestSearch();
	public String loadView(String name);
}
