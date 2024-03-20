run:
	psql -U alperentasdelen -d postgres -f task1.sql -A -F ','
	./run2.sh
	./pushtables.sh

clean:
	./droptables.sh

task1:
	make run
	psql -U alperentasdelen -d postgres -f task2_1.sql -o result1.csv -A -F ','

task2:
	make run
	psql -U alperentasdelen -d postgres -f task2_2.sql -o result2.csv -A -F ','

task3:
	make run
	psql -U alperentasdelen -d postgres -f task2_3.sql -o result3.csv -A -F ','

task4:
	make run
	psql -U alperentasdelen -d postgres -f task2_4.sql -o result4.csv -A -F ','

task5:
	make run
	psql -U alperentasdelen -d postgres -f task2_5.sql -o result5.csv -A -F ','

task6:
	make run
	psql -U alperentasdelen -d postgres -f task2_6.sql -o result6.csv -A -F ','

task7:
	make run
	psql -U alperentasdelen -d postgres -f task2_7.sql -o result7.csv -A -F ','

task8:
	make run
	psql -U alperentasdelen -d postgres -f task2_8.sql -o result8.csv -A -F ','

alltasks:
	make run
	psql -U alperentasdelen -d postgres -f task2_1.sql -o result1.csv -A -F ','
	psql -U alperentasdelen -d postgres -f task2_2.sql -o result2.csv -A -F ','
	psql -U alperentasdelen -d postgres -f task2_3.sql -o result3.csv -A -F ','
	psql -U alperentasdelen -d postgres -f task2_4.sql -o result4.csv -A -F ','
	psql -U alperentasdelen -d postgres -f task2_5.sql -o result5.csv -A -F ','
	psql -U alperentasdelen -d postgres -f task2_6.sql -o result6.csv -A -F ','
	psql -U alperentasdelen -d postgres -f task2_7.sql -o result7.csv -A -F ','
	psql -U alperentasdelen -d postgres -f task2_8.sql -o result8.csv -A -F ','