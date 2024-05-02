create database if not exists QUANLYDIEMTHI;
use QUANLYDIEMTHI;

#     drop database QUANLYDIEMTHI;
create table if not exists student
(
    studentId   varchar(4) primary key,
    studentName varchar(100) not null,
    birthday    date         not null,
    gender      bit(1)       not null,
    address     text         not null,
    phoneNumber varchar(45)
    );

create table if not exists subject
(
    subjectId   varchar(4) primary key,
    subjectName varchar(45) not null,
    priority    int(11)     not null
    );

create table if not exists Mark
(
    subjectId varchar(4) not null,
    studentId varchar(4) not null,
    point     int(11),
    primary key (studentId, subjectId)

    );
alter table Mark
    add constraint foreign key (studentId) references student (studentId),
    add constraint foreign key (subjectId) references subject (subjectId);

INSERT INTO student (studentId, studentName, birthday, gender, address, phoneNumber)
VALUES ('S001', 'Nguyễn Thế Anh', '1999-11-01', 1, 'Hà Nội', '984678082'),
       ('S002', 'Đặng Bảo Trâm', '1998-12-22', 0, 'Lào Cai', '904982654'),
       ('S003', 'Trần Hà Phương', '2000-05-05', 0, 'Nghệ An', '938472615'),
       ('S004', 'Đỗ Tiến Mạnh', '1999-03-26', 1, 'Hà Nội', '912345678'),
       ('S005', 'Phạm Duy Nhất', '1998-10-04', 1, 'Tuyên Quang ', '987654564'),
       ('S006', 'Mai Văn Thái', '2002-06-22', 1, 'Nam Đinh', '987654656'),
       ('S007', 'Giang Gia Hân', '1996-11-04', 0, 'Phú Thọ', '987654234'),
       ('S008', 'Nguyễn Ngọc Bảo My', '1999-01-22', 0, 'Hà Nam', '987654321'),
       ('S009', 'Nguyễn Tiến Đạt', '1998-08-07', 1, 'Tuyên Quang', '987654557'),
       ('S010', 'Nguyễn Thiều Quang', '2000-09-03', 1, 'Hà Nội', '987654291');

insert into subject (subjectId, subjectName, priority)
VALUES ('MH01', 'Toán', 2),
       ('MH02', 'Vật Lý', 2),
       ('MH03', 'Hóa Học', 1),
       ('MH04', 'Ngữ Văn', 1),
       ('MH05', 'Tiếng Anh', 2);

insert into MARK(studentId, subjectId, point)
values ('S001', 'MH01', 8.5),
       ('S001', 'MH02', 7),
       ('S001', 'MH03', 9),
       ('S001', 'MH04', 9),
       ('S001', 'MH05', 5),
       ('S002', 'MH01', 9),
       ('S002', 'MH02', 8),
       ('S002', 'MH03', 6.5),
       ('S002', 'MH04', 8),
       ('S002', 'MH05', 6),
       ('S003', 'MH01', 7.5),
       ('S003', 'MH02', 6.5),
       ('S003', 'MH03', 8),
       ('S003', 'MH04', 7),
       ('S003', 'MH05', 7),
       ('S004', 'MH01', 6),
       ('S004', 'MH02', 7),
       ('S004', 'MH03', 5),
       ('S004', 'MH04', 6.5),
       ('S004', 'MH05', 8),
       ('S005', 'MH01', 5.5),
       ('S005', 'MH02', 8),
       ('S005', 'MH03', 7.5),
       ('S005', 'MH04', 8.5),
       ('S005', 'MH05', 9),
       ('S006', 'MH01', 8),
       ('S006', 'MH02', 10),
       ('S006', 'MH03', 9),
       ('S006', 'MH04', 7.5),
       ('S006', 'MH05', 6.5),
       ('S007', 'MH01', 9.5),
       ('S007', 'MH02', 9),
       ('S007', 'MH03', 6),
       ('S007', 'MH04', 9),
       ('S007', 'MH05', 4),
       ('S008', 'MH01', 10),
       ('S008', 'MH02', 8.5),
       ('S008', 'MH03', 8.5),
       ('S008', 'MH04', 6),
       ('S008', 'MH05', 9.5),
       ('S009', 'MH01', 7.5),
       ('S009', 'MH02', 7),
       ('S009', 'MH03', 9),
       ('S009', 'MH04', 5),
       ('S009', 'MH05', 10),
       ('S010', 'MH01', 6.5),
       ('S010', 'MH02', 8),
       ('S010', 'MH03', 5.5),
       ('S010', 'MH04', 4),
       ('S010', 'MH05', 7);


-- #Bai 4
-- # 1. Tạo VIEW có tên STUDENT_VIEW lấy thông tin sinh viên bao gồm : mã học sinh, tên học
-- # sinh, giới tính , quê quán . [3 điểm]
create view student_view
as
select studentId, studentName, gender, address
from student;
-- # 2. Tạo VIEW có tên AVERAGE_MARK_VIEW lấy thông tin gồm:mã học sinh, tên học sinh,
-- # điểm trung bình các môn học . [3 điểm]

create VIEW AVERAGE_MARK_VIEW
as
select student.studentId, student.studentName, avg(M.point) as AveragePoint
from student
         join Mark M on student.studentId = M.studentId
group by student.studentId, student.studentName
having AveragePoint
;


-- # 3. Đánh Index cho trường `phoneNumber` của bảng STUDENT. [2 điểm]
CREATE INDEX idx_student_phone_number ON STUDENT (phoneNumber);


-- # 4. Tạo các PROCEDURE sau:
-- # - Tạo PROC_INSERTSTUDENT dùng để thêm mới 1 học sinh bao gồm tất cả
-- # thông tin học sinh đó. [3 điểm]
delimiter //
create procedure PROC_INSERTSTUDENT(in id_in varchar(4),
                                    in name_in varchar(100),
                                    in birthday_in date,
                                    in gender_in bit(1),
                                    in address_in text,
                                    in phoneNumber_in varchar(45)
)
begin
insert into student (studentId, studentName, birthday, gender, address, phoneNumber)
VALUES (id_in, name_in, birthday_in, gender_in, address_in, phoneNumber_in);
end;


call PROC_INSERTSTUDENT('S011', 'Nguyễn Thế Hieu', '1999-11-01', 1, 'Hà Nội', '984678082');



-- # - Tạo PROC_UPDATESUBJECT dùng để cập nhật tên môn học theo mã môn học.
delimiter //
create procedure PROC_UPDATESUBJECT(in id_in varchar(4),
                                    in name_in varchar(100),
                                    in priority_in int
)
    begin
        update subject set subjectName = name_in, priority = priority_in where subjectId = id_in;
    end ;//


call PROC_UPDATESUBJECT('MH02','demo',2);




-- # Tạo PROC_DELETEMARK dùng để xoá toàn bộ điểm các môn học theo mã học
-- # sinh. [3 điểm]
create procedure PROC_DELETEMARK(in id_in varchar(4)
)
begin
delete  from student
where studentId = id_in;
end;

call PROC_DELETEMARK(2);



