from pymysql import *
con = connect(host='localhost', user='root', password='password',
              database='test', port=3306, charset='utf8')
# 更改数据库用户名，密码，数据库为自己的
cursor = con.cursor()
# 使用 execute()  方法执行 SQL 查询
cursor.execute("SELECT VERSION()")
# 使用 fetchone() 方法获取单条数据.
data = cursor.fetchone()
print("Database version : %s " % data)
con.close()

