start:
	sudo service postgresql start

stop:
	sudo service postgresql stop

status:
	sudo service postgresql status

run:
	psql -U alperentasdelen -d postgres -f task1.sql -A -F ','
	./run2.sh
	./pushtables.sh

clean:
	./droptables.sh

task1:
	make run
	psql -U alperentasdelen -d postgres -f task2_1.sql -o result1.csv -A -F ','
	head -n -1 result1.csv > temp.csv
	mv temp.csv result1.csv

task2:
	make run
	psql -U alperentasdelen -d postgres -f task2_2.sql -o result2.csv -A -F ','
	head -n -1 result2.csv > temp.csv
	mv temp.csv result2.csv

task3:
	make run
	psql -U alperentasdelen -d postgres -f task2_3.sql -o result3.csv -A -F ','
	head -n -1 result3.csv > temp.csv
	mv temp.csv result3.csv

task4:
	make run
	psql -U alperentasdelen -d postgres -f task2_4.sql -o result4.csv -A -F ','
	head -n -1 result4.csv > temp.csv
	mv temp.csv result4.csv

task5:
	make run
	psql -U alperentasdelen -d postgres -f task2_5.sql -o result5.csv -A -F ','
	head -n -1 result5.csv > temp.csv
	mv temp.csv result5.csv

task6:
	make run
	psql -U alperentasdelen -d postgres -f task2_6.sql -o result6.csv -A -F ','
	head -n -1 result6.csv > temp.csv
	mv temp.csv result6.csv

task7:
	make run
	psql -U alperentasdelen -d postgres -f task2_7.sql -o result7.csv -A -F ','
	head -n -1 result7.csv > temp.csv
	mv temp.csv result7.csv

task8:
	make run
	psql -U alperentasdelen -d postgres -f task2_8.sql -o result8.csv -A -F ','
	head -n -1 result8.csv > temp.csv
	mv temp.csv result8.csv

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
	head -n -1 result1.csv > temp.csv
	mv temp.csv result1.csv
	head -n -1 result2.csv > temp.csv
	mv temp.csv result2.csv
	head -n -1 result3.csv > temp.csv
	mv temp.csv result3.csv
	head -n -1 result4.csv > temp.csv
	mv temp.csv result4.csv
	head -n -1 result5.csv > temp.csv
	mv temp.csv result5.csv
	head -n -1 result6.csv > temp.csv
	mv temp.csv result6.csv
	head -n -1 result7.csv > temp.csv
	mv temp.csv result7.csv
	head -n -1 result8.csv > temp.csv
	mv temp.csv result8.csv

compare1:
	make task1
	echo "comparing task2_1:"
	python3 compare1.py

compare2:
	make task2
	echo "comparing task2_2:"
	python3 compare2.py

compare3:
	make task3
	echo "comparing task2_3:"
	python3 compare3.py

compare4:
	make task4
	echo "comparing task2_4:"
	python3 compare4.py

compare5:
	make task5
	echo "comparing task2_5:"
	python3 compare5.py

compare6:
	make task6
	echo "comparing task2_6:"
	python3 compare6.py

compare7:
	make task7
	echo "comparing task2_7:"
	python3 compare7.py

compare8:
	make task8
	echo "comparing task2_8:"
	python3 compare8.py

compareall:
	make alltasks
	echo "comparing all tasks:"
	python3 compare1.py
	python3 compare2.py
	python3 compare3.py
	python3 compare4.py
	python3 compare5.py
	python3 compare6.py
	python3 compare7.py
	python3 compare8.py