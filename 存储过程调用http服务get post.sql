--sql ����������

--���� OLE Automation Procedures
sp_configure 'show advanced options', 1;   --��ѡ��������ʾsp_configureϵͳ�洢���̸߼�ѡ�����ֵΪ1ʱ������ʹ��sp_configure�г��߼�ѡ�Ĭ��Ϊ0��
GO
RECONFIGURE WITH OVERRIDE;
GO
sp_configure 'Ole Automation Procedures', 1;  --��ѡ���ָ���Ƿ������Transact-SQL��������ʵ����OLEAutomation ����
GO
RECONFIGURE WITH OVERRIDE;
GO
EXEC sp_configure 'Ole Automation Procedures';  --�鿴OLE Automation Procedures�ĵ�ǰ���á�
GO


--�洢���̵���ʾ��

declare @ServiceUrl as varchar(1000)
set @ServiceUrl = 'http://192.16.1.2:9905/clmsApi/thirdInterfaceDel/insertDatas'
DECLARE @data varchar(max);
--��������
set @data='{  
    "evtcode": "BD_DOC_04.SC0001.EV_DOC004",
    "input": {    "jk_type":1,
                "jzlb":2,
                "details": '+@jsonDatas+'
    }
}
    '                   
Declare @Object as Int
Declare @ResponseText AS  varchar(8000)   ;   
print 1;   
Exec sp_OACreate 'Msxml2.ServerXMLHTTP.3.0', @Object OUT;
print 2;
Exec sp_OAMethod @Object, 'open', NULL, 'POST',@ServiceUrl,'false'
print 3;
Exec sp_OAMethod @Object, 'setRequestHeader', NULL, 'Content-Type','application/json'
print 4;
Exec sp_OAMethod @Object, 'send', NULL, @data --��������
print 5;
Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
EXEC sp_OAGetErrorInfo @Object --�쳣���
print  @ResponseText
Exec sp_OADestroy @Object