<%@ page contentType ="text/html; charset=utf-8" %>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<%
        request.setCharacterEncoding("utf-8");
        String id = request.getParameter("id");
        String pw = request.getParameter("pw");

        ArrayList <String> passId = new ArrayList<String>();
        ArrayList <String> passPw = new ArrayList<String>();

        // MySQL JDBC Driver Loading
        Class.forName("com.mysql.cj.jdbc.Driver"); //JDBC 로딩 함수

        String jdbcDriver ="jdbc:mysql://localhost:3306/TestDB?serverTimezone=UTC"; 
        String dbUser ="tester"; //mysql id
        String dbPass ="1234"; //mysql password
        String query ="select * from user"; //query에 user의 * 속성 출력

        // Create DB Connection
        Connection conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass); //접속 시도

        // Create Statement
        Statement stmt = conn.createStatement(); //접속한 객체에 Statement 생성

        // Run Qeury
        ResultSet rs = stmt.executeQuery(query); //query 실행
        //rs : query를 실행한 결과 result set

        while(rs.next()){
                passId.add(rs.getString("id"));
                passPw.add(rs.getString("passwd"));
        }
%>

<%
        for(int i=0; i<passId.size(); i++){
                if(id.equals(passId.get(i))){ //같은 ID가 있을 시
                        out.println("<script>alert('같은 계정이 존재합니다.');</script>");
                }
                else{ //회원가입 진행
                        //SQL 삽입
                        String insert = "insert into user(ID, passWd) values ('" + id + "', '" + pw + "')";

                        //executeUpdate : SQL의 DML 수행
                        int count = stmt.executeUpdate(insert);
                        if(count == 1){ //성공적으로 저장 시
                                out.println("<script>alert('회원가입 완료');</script>");
                        }
                        else{
                                out.println("<script>alert('회원가입 실패');</script>");
                        }
                }
        } //for() 끝
        stmt.close();
        conn.close();
%>