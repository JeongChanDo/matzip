package com.matzip.app.kyj.dao;


import java.util.List;

import com.matzip.app.kyj.domain.Matzip;


public interface MatzipDao {
	
	public List<Matzip> getMatzipListAll(int startRow, int num);
	
	public int getMatzipCount();
	
	public Matzip getMatzip(int no, boolean state);
	
	public void insertMatzipRs(Matzip matzip);

	public void updateMatzipRs(Matzip matzip);
	
	public void deleteMatzipRs(int no);
	
	public List<Matzip> getMatzipByKeyword(String keyword, int startRow, int num);
	
	public List<Matzip> getMatzipByKeyword2(String keyword2, int startRow, int num);
	
}
