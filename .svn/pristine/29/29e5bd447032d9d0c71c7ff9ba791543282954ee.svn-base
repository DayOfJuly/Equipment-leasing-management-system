package com.hjd.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.hjd.base.IDomainBase;
/**
 * @author Qian
 *
 */
@Entity
@Table(name="bus_refuse_reason")
public class BusRefuseReasonTable implements IDomainBase {
	
		/**
		 * 
		 */
		private static final long serialVersionUID = 4478274421668524973L;
		
		@Transient
		public Object getObjectId() {return this.id;}
		//数据的ID，记录主键
		@Id
		@Column(name="id", unique=true, nullable=false) 
		@GeneratedValue(strategy=GenerationType.IDENTITY)
		private Long id;//拒绝原因记录ID
		
		private Long dataId;//发布的信息ID
		
		private Integer reasonId;//拒绝原因ID
		
		private String reasonNote;//拒绝原因说明

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public Long getDataId() {
			return dataId;
		}

		public void setDataId(Long dataId) {
			this.dataId = dataId;
		}

		public Integer getReasonId() {
			return reasonId;
		}

		public void setReasonId(Integer reasonId) {
			this.reasonId = reasonId;
		}

		public String getReasonNote() {
			return reasonNote;
		}

		public void setReasonNote(String reasonNote) {
			this.reasonNote = reasonNote;
		}

	}
