-- vbでSQLサーバへ接続。
Imports System.Data.SqlClient

Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        -- SQLServerへ接続する。
        Dim cn As New SqlConnection("Server=Server名; Database=データベース名; Integrated Security=認証方法")
        cn.Open()
        -- 実行したいSQL文を設定、どのServerか指定。
        Dim cmd As New SqlCommand("SELECT * FROM 商品", cn)
        -- ExecuteReaderメソッドでSQLを実行、結果をSqlDataReaderクラスで受け取る。
        Dim dr As SqlDataReader = cmd.ExecuteReader()
        -- データの分だけ繰り返し実行する。Readメソッドは読み込みがないと
        While dr.Read()
            Me.ListBox1.Items.Add(dr("商品名").ToString())
        End While
        -- Closeメソッドでデータを解放する
        dr.Close()
        cn.Close()
    End Sub
End Class


-- 途中でエラーが出た時の対応
Imports System.Data.SqlClient

Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Using cn As New SqlConnection("Server=Server名; Database=データベース名; Integrated Security=認証方法")
            Using cmd As New SqlCommand("SELECT * FROM 商品", cn)
                Try
                    cn.Open()
                    Using dr As SqlDataReader = cmd.ExecuteReader()
                        While dr.Read()
                            Me.ListBox1.Items.Add(dr("商品名").ToString())
                        End While
                    End Using
                Catch ex As Exception
                    MessageBox.Show(ex.Message)
                Finally
                    cn.Close()
                End Try
            End Using
        End Using
    End Sub
End Class


-- SQLインジェクト対策
Imports System.Data.SqlClient

Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Using cn As New SqlConnection("Server=Server名; Database=データベース名; Integrated Security=認証方法")
            Using cmd As New SqlCommand("SELECT 商品名 FROM 商品 WHERE 区分コード = @p1", cn)
                Dim p1 As SqlParameter = cmd.Parameters.Add("@p1", System.Data.SqlDbType.Int)
                p1.Value = Me.TextBox1.Text
                Try
                    cn.Open()
                    Using dr As SqlDataReader = cmd.ExecuteReader()
                        While dr.Read()
                            Me.ListBox1.Items.Add(dr("商品名").ToString())
                        End While
                    End Using
                Catch ex As Exception
                    MessageBox.Show(ex.Message)
                Finally
                    cn.Close()
                End Try
            End Using
        End Using
    End Sub
End Class


-- 更新と複数実行
Imports System.Data.SqlClient

Public Class Form1
    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Using cn As New SqlConnection("Server=Server名; Database=データベース名; Integrated Security=認証方法")
            Using cmd As New SqlCommand("UPDATE 商品 SET 商品名=@p2 WHERE 商品コード=@p1", cn)
                Dim p1 As SqlParameter = cmd.Parameters.Add("@p1", System.Data.SqlDbType.Int)
                p1.Value = Me.TextBox1.Text
                Dim p2 As SqlParameter = cmd.Parameters.Add("@p2", System.Data.SqlDbType.NVarChar, 40)
                p2.Value = Me.TextBox2.Text
                Try
                    cn.Open()
                    Dim p3 As Integer
                    p3 = cmd.ExecuteNonQuery()
                    MessageBox.Show(p3.ToString + "件更新しました")
                Catch ex As Exception
                    MessageBox.Show(ex.Message)
                Finally
                    cn.Close()
                End Try
            End Using
            Using cmd As New SqlCommand("SELECT 商品名 FROM 商品 WHERE 区分コード = @p1", cn)
                Dim p1 As SqlParameter = cmd.Parameters.Add("@p1", System.Data.SqlDbType.Int)
                p1.Value = Me.TextBox1.Text
                Try
                    cn.Open()
                    Using dr As SqlDataReader = cmd.ExecuteReader()
                        While dr.Read()
                            Me.ListBox1.Items.Add(dr("商品名").ToString())
                        End While
                    End Using
                Catch ex As Exception
                    MessageBox.Show(ex.Message)
                Finally
                    cn.Close()
                End Try
            End Using
        End Using
    End Sub
End Class
