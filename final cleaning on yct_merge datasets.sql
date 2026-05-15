-- DATA CLEANING FOR YABATECH MERGED ADMISSION AND GRADUATION DATASETS

-- DATASETS OVERVIEW
select * 
from yabatech.yct_merge;

-- DROPPING OF DUPLICATES COLUMN FROM THE TABLE

alter table yabatech.yct_merge
drop `Nationality_[0]`;

alter table yabatech.yct_merge
drop `Admission_Year_[0]`;

alter table yabatech.yct_merge
drop phone_number;

alter table yabatech.yct_merge
drop guardian_phone;

alter table yabatech.yct_merge
drop admission_date;

alter table yabatech.yct_merge
drop program;

alter table yabatech.yct_merge
drop graduation_date;


-- RENAMING COLUMN 
alter table yabatech.yct_merge
change column `synthetic_yabatech_graduation_records_4pt_final.Graduation_Date` Graduation_date  text;

-- CHECKING AND REMOVING DUPLICATE ITEMS

with duplicate_cte as (select*, row_number()
over(partition by Student_ID,Admission_Year,Admission_Date,Department,Program,Entry_Mode,Entry_Score,
Qualification_Submitted,Nationality,State_of_origin,Local_Government_Area,Religion,Address,Guardian_Name,Previous_School,
Scholarship_Status,Hostel_Requested,Admission_Batch,Full_Name,Gender,Date_of_Birth,Age_at_Graduation,Graduation_year,
Graduation_date,Final_CGPA,Class_of_Degree,Graduation_Status,Honors_or_Awards  order by Student_ID)
 as row_num
 from yabatech.yct_merge
 ) select *
 from duplicate_cte
 where row_num >1;

-- STANDARDIZATION OF DATE OF BIRTH
SELECT date_of_birth,
       STR_TO_DATE(date_of_birth, '%m/%d/%Y') AS Date_of_birth
FROM yabatech.yct_merge;

-- UPDATING OF CHANGED DATE_OF_BIRTH DATA TYPE

update yabatech.yct_merge
set date_of_birth =  STR_TO_DATE(date_of_birth, '%m/%d/%Y');

-- UPDATING AND REMOVING UNCLEANED CHARACTER FROM ROW

	select full_name
    from yabatech.yct_merge
    where full_name ='á»ŒlÃ¡chukwu oyedepo';
    
    update yabatech.yct_merge
    set full_name = 'chukwu oyedepo'
    where full_name = 'á»ŒlÃ¡chukwu oyedepo';

 update yabatech.yct_merge
    set full_name = 'chukwu yakubu'
    where full_name = 'á»ŒlÃ¡chukwu yakubu';

update yabatech.yct_merge
    set full_name = 'chukwu okechukwu'
    where full_name = 'á»ŒlÃ¡chukwa okechukwu';

update yabatech.yct_merge
    set full_name = 'chukwu oloruntoba'
    where full_name = 'á»ŒlÃ¡chukwu oloruntoba';




update yabatech.yct_merge
    set full_name = 'chukwu okoye'
    where full_name = 'á»ŒlÃ¡chukwu okoye';

update yabatech.yct_merge
    set full_name = 'chukwu olatunji'
    where full_name = 'á»ŒlÃ¡chukwu olatunji';

update yabatech.yct_merge
    set full_name = 'chukwu ahmed'
    where full_name = 'á»ŒlÃ¡chukwu ahmed';


update yabatech.yct_merge
    set full_name = 'chukwu bello'
    where full_name = 'á»ŒlÃ¡chukwu Bello';
    
    update yabatech.yct_merge
    set full_name = 'chukwu onyeka'
    where full_name = 'á»ŒlÃ¡chukwu onyeka';

				update yabatech.yct_merge
    set full_name = 'chukwu osho'
    where full_name = 'á»ŒlÃ¡chukwu osho';
    
    
							update yabatech.yct_merge
    set full_name = 'chukwu olawale'
    where full_name = 'á»ŒlÃ¡chukwu olawale';


update yabatech.yct_merge
    set full_name = 'chukwu adebayo'
    where full_name = 'á»ŒlÃ¡chukwu adebayo';

				update yabatech.yct_merge
    set full_name = 'chukwu ebong'
    where full_name = 'á»ŒlÃ¡chukwu ebong';


				update yabatech.yct_merge
    set full_name = 'chukwu adeoye'
    where full_name = 'á»ŒlÃ¡chukwu adeoye';
    
    
    				update yabatech.yct_merge
    set full_name = 'chukwu okechukwu'
    where full_name = 'á»ŒlÃ¡chukwu Okechukwu';


	update yabatech.yct_merge
    set full_name = 'chukwu okoro'
    where full_name = 'á»ŒlÃ¡chukwu Okoro';

	update yabatech.yct_merge
    set full_name = 'chukwu kolawola'
    where full_name = 'á»ŒlÃ¡chukwu kolawole';


	update yabatech.yct_merge
    set full_name = 'chukwu ibe'
    where full_name = 'á»ŒlÃ¡chukwu Ibe';


update yabatech.yct_merge
    set full_name = 'chukwu enahoro'
where full_name = 'á»ŒlÃ¡chukwu enahoro';


update yabatech.yct_merge
			set full_name = 'chukwu ibrahim'
where full_name = 'á»ŒlÃ¡chukwu ibrahim';

						update yabatech.yct_merge
    set full_name = 'chukwu echendu'
			where full_name = 'á»ŒlÃ¡chukwu echendu';
    
          
	update yabatech.yct_merge
    set full_name = 'chukwu abimbola'
				where full_name = 'á»ŒlÃ¡chukwu abimbola';

update yabatech.yct_merge
    set full_name = 'chukwu Nwachukwu'
				where full_name = 'á»ŒlÃ¡chukwu Nwachukwu';


update yabatech.yct_merge
    set full_name = 'chukwu Nwachukwu'
				where full_name = 'á»ŒlÃ¡chukwu ali';





select * from yabatech.yct_merge;

-- DATA EXRTRACTION FROM CLEANED DATABASE
	-- 1. List top 10 students with highest Entry_Score per department.
    
        select Department, full_name,
    entry_score  from yabatech.yct_merge
    order by entry_score desc limit 10;
    
    -- 2. Calculate average Final_CGPA by department. 
    
    SELECT department,
       ROUND(AVG(final_cgpa), 2) AS Average_CGPA
FROM yabatech.yct_merge
GROUP BY department;

-- 3. Find number of students who graduated with Distinction. 

SELECT class_of_degree,
       COUNT(student_id) AS total_students
      FROM yabatech.yct_merge
       where class_of_degree = 'distinction'
GROUP BY class_of_degree;
    
    -- 3.  Show total admissions per year by Entry_Mode.. 

select admission_year, entry_mode, count(student_id) as Total_Admission
from yabatech.yct_merge
group by Admission_Year, Entry_Mode;


    -- 4. Count students per state who had full scholarships. 
    
    select state_of_origin, scholarship_status, count(student_id) as number_of_students
    from yabatech.yct_merge
    where Scholarship_Status = 'full'
    group by State_of_origin;
    
    
     -- 5. Retrieve all students who failed to graduate.
     select full_name, graduation_status
     from yabatech.yct_merge
     where Graduation_Status = 'fail out'
     group by Full_Name;
     

	
