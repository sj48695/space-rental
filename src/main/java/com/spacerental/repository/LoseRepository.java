package com.spacerental.repository;

import java.util.ArrayList;
import java.util.List;

import com.spacerental.vo.Host;
import com.spacerental.vo.Lose;
import com.spacerental.vo.LoseFile;
import com.spacerental.vo.Member;
import com.spacerental.vo.Rent;

public interface LoseRepository {

	void insertLose(Lose lose);

	void insertLoseFile(LoseFile file);

	void insertlose2(Lose lose);

	List<Lose> findList();

	int registerlose(Lose lose);

	void registerloseFile(LoseFile file);

	// void registerloseUpload2(Lose lose);

	Lose findloseByLoseNo(int loseNo);

	List<LoseFile> selectLoseFilesByLoseNo(int loseNo);

	void updateLoseUpdate(Lose lose);

	void loseDelete(int loseNo);

	Lose loseDetail(int loseNo);

	List<Lose> loseList(String type);

	//void registerlose2(Lose lose);
	
	ArrayList<Lose> searchlossList(String value);

	ArrayList<Host> selectHostNoById(String id);

//	List<Rent> selectrentList(String id);
	

}
