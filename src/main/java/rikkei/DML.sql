use QUANLYDIEMTHI;

# 2. Cập nhật dữ liệu [10 điểm]:
# - Sửa tên sinh viên có mã `S004` thành “Đỗ Đức Mạnh”.

update STUDENT
set studentName = 'Đỗ Đức Mạnh'
where studentId = 'S004';

# - Sửa tên và hệ số môn học có mã `MH05` thành “Ngoại Ngữ” và hệ số là 1.

update subject
set subjectName = 'Ngoại Ngữ',
    priority    = 1
where subjectId = 'MH05';

# - Cập nhật lại điểm của học sinh có mã `S009` thành (MH01 : 8.5, MH02 : 7,MH03 : 5.5, MH04 : 6,
# MH05 : 9).
update Mark
set point = case
                when subjectId = 'MH01' then 8.5
                when subjectId = 'MH02' then 7
                when subjectId = 'MH03' then 5.5
                when subjectId = 'MH04' then 6.5
    end
where studentId = 'S009';

# 3. Xoá dữ liệu[10 điểm]:
# - Xoá toàn bộ thông tin của học sinh có mã `S010` bao gồm điểm thi ở bảng MARK và thông tin học sinh
# này ở bảng STUDENT.

delete
from Mark
where studentId = 'S010';
delete
from STUDENT
where studentId = 'S010';


#         Bài 3: Truy vấn dữ liệu [25 điểm]:
#         1. Lấy ra tất cả thông tin của sinh viên trong bảng Student . [4 điểm]

select *
from STUDENT;

#         2. Hiển thị tên và mã môn học của những môn có hệ số bằng 1. [4 điểm]

select subject.subjectName, subject.subjectId
from subject
where priority = 1
;
#         3. Hiển thị thông tin học sinh bào gồm: mã học sinh, tên học sinh, tuổi (bằng năm hiện tại trừ
#         năm sinh) , giới tính (hiển thị nam hoặc nữ) và quê quán của tất cả học sinh. [4 điểm]
select studentId,
       studentName,
       (year(curdate()) - year(birthday)) as Tuoi,
       (case
            when gender = 1 then 'Nam'
            when gender = 0 then 'Nu'
           end)                           as GioiTinh,
       address
from STUDENT;

#         4. Hiển thị thông tin bao gồm: tên học sinh, tên môn học , điểm thi của tất cả học sinh của môn
#         Toán và sắp xếp theo điểm giảm dần. [4 điểm]

            select Mark.point , st.studentName, subject.subjectName from STUDENT st join Mark on Mark.studentId = st.studentId
            join subject on subject.subjectId = Mark.subjectId
            where subjectName = 'Toán'
            order by Mark.point desc;

#         5. Thống kê số lượng học sinh theo giới tính ở trong bảng (Gồm 2 cột: giới tính và số lượng).
#         [4 điểm]

            select ( select count(*) from STUDENT where gender = 1) as GioiTinhNam,(select count(*) from STUDENT where gender = 0) as GioiTinhNu;

#         6. Tính tổng điểm và điểm trung bình của các môn học theo từng học sinh (yêu cầu sử dụng hàm
#         để tính toán) , bảng gồm mã học sinh, tên hoc sinh, tổng điểm và điểm trung bình. [5 điểm]

            select st.studentId, st.studentName, sum(point) as TongDiem, avg(point) as DiemTrungBinh
            from STUDENT st join Mark on Mark.studentId = st.studentId
            group by st.studentId, st.studentName
            ;