from flask import Flask,render_template,request,redirect,session
from flaskext.mysql import MySQL
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail
mysql = MySQL()


app = Flask(__name__)
app.secret_key="hello"

app.config['MYSQL_DATABASE_USER']='N2xPXoMdDK'
app.config['MYSQL_DATABASE_PASSWORD']='SkC3hQwn5D'
app.config['MYSQL_DATABASE_DB']='N2xPXoMdDK'
app.config['MYSQL_DATABASE_HOST']='remotemysql.com'

mysql = MySQL(app)

@app.route('/')
def root():
    return redirect('/demo')
@app.route("/demo")
def demo():
    return render_template('demo.html')

@app.route("/admin",methods=['GET','POST'])
def admin():
    if request.method=="POST":
        username=request.form['fname']
        
        password=request.form['pass']
        session['username']  = username
        conn=mysql.connect()
        cur=conn.cursor()
        cur.execute("select `password`,`email` from `adminregister` WHERE `name`=%s",(username))
        data=cur.fetchall()
        emailid=data[0][1]
        session['emailid']=emailid
        
        
        if password==data[0][0]:
            return redirect('/income')
        else:
            return " admin login failed"

    else:

        return render_template('login.html')

@app.route("/adminregister",methods=['GET','POST'])

def adminregister():
    if request.method=="POST":
        username=request.form['fname']
        password1=request.form['pass']
        emailid=request.form['emailid']
        session['emailid']=emailid
        session['username']  = username
        conn=mysql.connect()
        cur=conn.cursor()
        cur.execute("INSERT INTO `adminregister`(`name`, `password`, `email`) VALUES(%s,%s,%s)",(username,password1,emailid))
        conn.commit()
        return redirect('/income')

        

    else:

        return render_template('signup.html')
    
@app.route("/logout")
def logout():
    return render_template('demo.html')

    
@app.route("/add",methods=['GET','POST'])
def add():
    if request.method=="POST":
        
        un=request.form['un']
        pn=request.form['pn']
        pd=request.form['pd']
        pr=request.form['pr']
       
        session['username']=un
        conn=mysql.connect()
        cur=conn.cursor()
    
        cur.execute("INSERT INTO `expense`(`username`,`expensename`,`expensedesc`, `amount`) VALUES(%s,%s,%s,%s)",(un,pn,pd,pr))
        conn.commit()

        
        return redirect('view')

    else:
        
        return render_template('view.html')
    
@app.route("/addincome",methods=['GET','POST'])
def addincome():
    if request.method=="POST":
        
        pn=request.form['pn']
        
        pr=request.form['pr']
       
        session['username']=pn
        conn=mysql.connect()
        cur=conn.cursor()
        cur.execute("INSERT INTO `income`(`username`,`income`,`balance`) VALUES(%s,%s,%s)",(pn,pr,0))
        conn.commit()
        
        
        return redirect('income')

    else:
        
        return render_template('income.html')    
    
@app.route("/edit",methods=['GET','POST'])
def edit():
    if request.method=="POST":
        
        id=request.form['id']
        un=request.form['un']
        expensename=request.form['expensename']
        expensedesc=request.form['expensedesc']
        amount=request.form['amount']
        

        conn=mysql.connect()
        cur=conn.cursor()
        cur.execute("UPDATE `expense` SET `username`='"+un+"', `expensename`='"+expensename+"',`expensedesc`='"+expensedesc+"' ,`amount`='"+amount+"'WHERE `id`='"+id+"'")
        conn.commit()
        return redirect('view')
    else:
        id=request.args.get('id')
        conn=mysql.connect()
        cur=conn.cursor()
        cur.execute("select * from expense where `id`='"+str(id)+"'")
        data=cur.fetchone()
        return render_template('edit.html',product=data)
    
@app.route("/delete",methods=['GET','POST'])
def delete():
    id=request.args.get('id')
    conn=mysql.connect()
    cur=conn.cursor()
    
    cur.execute("DELETE FROM `expense` WHERE `id`='"+id+"'")
    conn.commit()
    return redirect('view')


@app.route("/view",methods=['GET','POST'])
def view():
    conn=mysql.connect()
    cur=conn.cursor()
    
    cur.execute("select * from expense where username=%s" ,(session['username'],))
    data=cur.fetchall()
    
    
    
    
    return render_template('view.html',data=data)

@app.route("/income",methods=['GET','POST'])
def income():
    conn=mysql.connect()
    cur=conn.cursor()
    
    cur.execute("select * from income where username=%s" ,(session['username'],))
    data=cur.fetchall()
    
    
    
    
    return render_template('income.html',data=data)

@app.route("/calculate",methods=['GET','POST'])
def calculate():
    from flask import session
    conn=mysql.connect()
    cur=conn.cursor()
        
    cur.execute("select `income` from income where username=%s" ,(session['username'],))
    data=cur.fetchall()
        
    cur.execute("select sum(amount) from expense where username=%s" ,(session['username'],))
    abc=cur.fetchall()
        
    threshold=float(data[0][0])*2/100
    if float(abc[0][0])>=threshold:
            
        message = Mail(from_email='salonimp1999@gmail.com',
                       to_emails=session['emailid'],
                       subject='ALERT MESSAGE TO CUSTOMERS',
                       plain_text_content='you have crossed your daily limit',
                       html_content='<strong>you have crossed your daily limit</strong>')
        try:
            sg = SendGridAPIClient('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')
            response = sg.send(message)
            print(response.status_code)
            print(response.body)
            print(response.headers)
        except Exception as e:
            print(e)
                
    result=str(float(data[0][0])-float(abc[0][0]))
        
        
    cur.execute("UPDATE `income` SET `balance`='"+str(result)+"' where username=%s" ,(session['username'],))
    conn.commit()
        
    return redirect('income')

   
@app.route("/saving",methods=['GET','POST'])
def saving():

    if request.method=="POST":
        conn=mysql.connect()
        cur=conn.cursor()
        saving=request.form['save']
        cur.execute("select `balance` from income where username=%s" ,(session['username'],))
        data=cur.fetchall()
    
    
        result=str(float(data[0][0])+float(saving))
    
    
        cur.execute("UPDATE `income` SET `balance`='"+result+"' where username=%s" ,(session['username'],))
        conn.commit()
        return redirect('/income')

        

    else:
        return render_template('saving.html')

        
if __name__=="__main__":
    app.run(host='0.0.0.0',debug = True,port=8080)