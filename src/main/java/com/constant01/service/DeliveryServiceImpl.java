package com.constant01.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.constant01.mapper.DeliveryMapper;
import com.constant01.model.AdminDTO;
import com.constant01.model.DeliveryDTO;
import com.constant01.model.DriverDTO;

@Service
public class DeliveryServiceImpl implements DeliveryService{
	@Autowired
	DeliveryMapper dm;
	
	// 기사 로그인입디다 
	public DriverDTO login(DriverDTO driver) {
		return dm.login(driver);
		
	}
	
	public AdminDTO login2(AdminDTO admin) {
		return dm.login2(admin);
	}
	
	public void write(DeliveryDTO delivery) {
		dm.write(delivery);
	}

	public ArrayList<DriverDTO> list(DriverDTO driver){
		return dm.list(driver);
	}
	
	//여기에 최종 기사 위치 저장 1
	public ArrayList<DriverDTO> dlist(DeliveryDTO delivery) {

		return dm.dlist(delivery);
	}
	
	public void delete(DeliveryDTO delivery) {
		dm.delete(delivery);
	}


}
