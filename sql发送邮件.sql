--1.����Database Mail��չ�洢����
sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
sp_configure 'Database Mail XPs', 1
GO
RECONFIGURE
GO
sp_configure 'show advanced options', 0
GO
RECONFIGURE
GO
 
--2.���account
exec msdb..sysmail_add_account_sp
        @account_name            = 'zhanghao' --�ʼ��ʻ�����SQL Server ʹ��
       ,@email_address           = 'zhanghao@126.com' --�������ʼ���ַ
       ,@mailserver_name         = 'smtp.126.com'        --�ʼ���������ַ
       ,@mailserver_type         = 'SMTP'                --�ʼ�Э��SQL 2005ֻ֧��SMTP
       ,@port                    = 25                    --�ʼ��������˿�
       ,@username                = 'zhanghao' --�û���
       ,@password                = 'mima' --����
        
--3.���profile
exec msdb..sysmail_add_profile_sp
@profile_name = 'dba_profile'-- profile ����
   ,@description  = 'dba mail profile'-- profile ����
   ,@profile_id   = null
    
--4.ӳ��account��profile
exec msdb..sysmail_add_profileaccount_sp  
@profile_name    = 'dba_profile'-- profile ����
   ,@account_name    = 'zhanghao'-- account ����
   ,@sequence_number = 1-- account ��profile��˳��
  
--5.1�����ı��ʼ�
exec msdb..sp_send_dbmail
@profile_name =  'dba_profile'
   ,@recipients   =  'xxx@qq.com'
   ,@subject      =  'SQL Server�ʼ�����'
   ,@body         =  '���ݰ�'
   ,@body_format  =  'TEXT'
    
--5.2���͸���
EXEC sp_send_dbmail
    @profile_name = 'dba_profile',
    @recipients = 'xxx@qq.com',
    @subject = '���Ǹ���',
@file_attachments ='G:\���߰���\sql.txt'
 
--5.3���Ͳ�ѯ���
EXEC sp_send_dbmail
    @profile_name = 'dba_profile',
    @recipients = 'xxx@qq.com',
    @subject = '���ǲ�ѯ',
@query='select * from test.dbo.apo_city'
    
--6.�鿴�ʼ��������
select * from sysmail_allitems
select * from sysmail_mailitems
select * from sysmail_event_log
 
--7.ɾ���ʼ�����
Exec msdb..sysmail_delete_profileaccount_sp  
@profile_name = 'dba_profile',
    @account_name = 'zhanghao'
Exec msdb..sysmail_delete_profile_sp
@profile_name = 'dba_profile'
Exec msdb..sysmail_delete_account_sp
@account_name ='zhanghao'