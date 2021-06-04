--What grades are stored in the database?
select * from Grade;

--What emotions may be associated with a poem?
select * from Emotion;

--How many poems are in the database?
select count(*) as numOfPoems from Poem;

--Sort authors alphabetically by name. What are the names of the top 76 authors?
select top 76 
Author.Name 
from author 
order by Author.Name;

--Starting with the above query, add the grade of each of the authors.
select top 76 
Author.Name,
grade.Name
from author 
left join grade on Author.GradeId = Grade.Id
order by Author.Name;

--Starting with the above query, add the recorded gender of each of the authors.
select top 76 
Author.Name,
grade.Name,
gender.Name
from author 
left join grade on Author.GradeId = Grade.Id
left join Gender on Author.GenderId = Gender.Id
order by Author.Name;

--What is the total number of words in all poems in the database?
select sum(WordCount) as TotalWordCount
from Poem;


--Which poem has the fewest characters?
select top 1 CharCount, Title
from Poem
order by CharCount asc;


--How many authors are in the third grade?
select
count(author.Id) as ThirdGraders
from Author
left join grade on Author.GradeId = Grade.Id
where grade.Name = '3rd Grade';



--How many total authors are in the first through third grades?
select
grade.Name,
count(author.id) as YoungAuthors
from Author
left join Grade on Author.GradeId = Grade.Id
where grade.Name between '1st Grade' and '3rd grade'
group by grade.Name;

--What is the total number of poems written by fourth graders?
select count(poem.id) as Total4thGradePoems
from Poem
left join author on Poem.AuthorId = Author.Id
left join grade on Author.GradeId = Grade.Id
where Grade.Name = '4th Grade';


--How many poems are there per grade?
select 
grade.name,
count(poem.id) as TotalPoems
from Poem
left join author on Poem.AuthorId = Author.Id
left join grade on Author.GradeId = Grade.Id
group by grade.Name
order  by count(poem.id) asc;

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select 
grade.name,
count(author.id) as TotalAuthors
from author
left join grade on author.GradeId = Grade.Id
group by grade.name
order by grade.name asc;

--What is the title of the poem that has the most words?
select top 1 Title
from Poem
order by WordCount desc;

--Which author(s) have the most poems? (Remember authors can have the same name.)
select top 3 poem.AuthorId,
Author.Name,
count(author.Id) as AuthorIds
from poem
left join author on Author.id = poem.AuthorId
group by poem.AuthorId, author.Name
order by count(author.id) desc;

--How many poems have an emotion of sadness?
select count(*) as SadPoems
from PoemEmotion
left join Emotion on PoemEmotion.EmotionId = Emotion.Id
where Emotion.Name = 'Sadness'

--How many poems are not associated with any emotion?
select count(*) as NoEmotions
from Poem
left join PoemEmotion on Poem.Id = PoemEmotion.PoemId
where PoemEmotion.EmotionId is null


--Which emotion is associated with the least number of poems?
select top 1
Emotion.name,
count(PoemEmotion.EmotionId) as PoemsWithEmotion
from Emotion
left join PoemEmotion on PoemEmotion.EmotionId = Emotion.Id
group by Emotion.Name 
order by count(PoemEmotion.EmotionId) asc

--Which grade has the largest number of poems with an emotion of joy?
select top 1 count(poem.id) as NumOfPoems,
grade.name
from Poem
left join Author on poem.AuthorId = Author.Id
left join grade on Author.GradeId = Grade.Id
group by grade.Name
order by count(poem.id)  desc

--Which gender has the least number of poems with an emotion of fear?
select top 1 count(poem.Id) as NumOfPoems,
Gender.Name as Gender,
Emotion.Name as Emotion
from Poem
left join Author on poem.AuthorId = Author.Id
left join Gender on Author.GenderId = Gender.Id
left join PoemEmotion on PoemEmotion.PoemId = Poem.Id
left join Emotion on PoemEmotion.EmotionId = Emotion.Id
where Emotion.name = 'fear'
group by Gender.Name, Emotion.Name
order by count(poem.Id) asc