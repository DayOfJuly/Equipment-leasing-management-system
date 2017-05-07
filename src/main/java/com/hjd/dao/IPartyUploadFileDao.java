package com.hjd.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.hjd.domain.Party;
import com.hjd.domain.PartyUploadFile;
import com.hjd.domain.UploadFileInfo;

public interface IPartyUploadFileDao extends JpaRepository<PartyUploadFile, Long> {

	public void deleteByParty(@Param("party") Party party);
	
	@Query("delete from PartyUploadFile t where t.uploadFile.uploadId=:uploadId")
	@Modifying
	public void deletePersonPic(@Param("uploadId") Long uploadId);

	@Query(value="select partyFile.uploadFile from PartyUploadFile partyFile where partyFile.party=:party")
	public List<UploadFileInfo> findUploadFileByParty(@Param("party") Party party);

	}
