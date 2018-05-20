require 'rubygems'
require 'movieDB/base.rb'
require 'engtagger'
require 'themoviedb'

#require 'ruby-tmdb'


Tmdb::Api.key("4064d13e9116b37aae49a206632207e9")
Tmdb::Api.language("en")

# Формирует из заданной строки массив со всеми существительными (англ)
def find_nouns(string)
	# Подключаем таггер, массив цензуры, и правильный массив цензуры
	tgr = EngTagger.new
	#p tgr.methods - Object.methods
	right_censure = []
	i = 0
	# помечаем все слова и знаки тэгами
	word_list = tgr.add_tags(string)
	
	# Поиск всех существительных 
	nouns 	= tgr.get_words(word_list).to_a
	
	until i >= nouns.length
		right_censure.push(nouns[i][0])
		i += 1
	end
	right_censure
end

# Проверка на то, является ли данное слово глаголом в данной строке
def is_a_noun?(word, string)
	find_nouns(string).include?(word)
end

$max_loop_counter = 0
# Вовзращает преобразованную строку из символов
def film_to_oleg(film)
	p @answer = film # D E B U G !!!!
	p $answer = film
	film = film.split(' ') # раскладываем фильм на слова
	# Если фильм не состоит из двух слов с The и если его длина больше 1
	n = ""
	hash = Hash[film.map.with_index.to_a]
	i = 0
	until (i >= (film.count)) ||
		  film.include?("Oleg") ||
		  film.include?("Olegs") do
		n = film.sample
		s = hash[n]
		if n.length > 3 && 
			 is_a_noun?(n, film.join(' ')) && 
			 /[0-9]/.match(n).nil?
			p $word_answer = n			
			n = "Olegs"
		end
		film[s] = n
		i += 1
		$max_loop_counter += 1
	end
	if film.include?("Oleg") || film.include?("Olegs") 
		film.join(" ")
	elsif $max_loop_counter >= 5
		film_to_oleg(get_random_film_name)
		$max_loop_counter = 0
	else
		film_to_oleg(film.join(' '))
	end
end


# p 



#p @search.resource(imdb_id) # determines type of resource
p #@search.query('samuel jackson') # the query to search against
def get_random_film_name		
	random_imdb_id = "tt0" + Random.rand(300000).to_s
	movie = Tmdb::Find.imdb_id(random_imdb_id)
	if movie.keys.include?('movie_results') && !movie['movie_results'].empty?
		m = movie['movie_results'][0]['title'].split(' ') 
		if (m.include?("The") && m.length == 2) || m.length == 1
			get_random_film_name
		else
			m
		end
	else
		get_random_film_name
	end
end



def match_numbers(str)
	!/[0-9]/.match(str).nil?	
end

def get_valid_film_name(film)
	tgr = EngTagger.new
	valid_words = tgr.add_tags(film)
	valid_words_1 = tgr.get_nouns(valid_words)
	if !valid_words_1.nil?
		film
	else
		film = get_random_film_name
		get_valid_film_name(film)
	end
	#film = "1942 abc zxcac"

end

#p match_numbers("1942 abc zxc")
#
#p film_to_oleg("1942 abc zxcac")
#
#T = Time.now
#
#p get_random_film_name
#p TN = Time.now - T
#a = "1"
#a.split(' ')



#p film_to_oleg(get_valid_film_name(get_random_film_name))



#p find_nouns("Alice chased egors find rhino and take take takes took taking the big fat cat.")
super_array = (1..1000).to_a

def array_print_while(array)
	i = 0
	while i < array.count
		p array[i]
		i += 1
	end
end

def array_print_map(array)
	array.map { |elem| p elem }
end

#@search = Tmdb::Search.new
#@search.resource('movie') # determines type of resource
#p @search.query('Lazy Little Beaver') # the query to search against
#p result = @search.fetch # makes request
##p movie['movie_results'][0]['title'].split(' ') 
#p result[0]['original_language']

def only_3_symbol_nouns?(str)
	nouns = find_nouns(str.join(' '))
	answer = true
	nouns.each {|elem| elem.length > 3 ? answer = false : "" }
	answer
end

p only_3_symbol_nouns?(['original', 'lann'])
p only_3_symbol_nouns?(['ori', 'gin', 'aal'])
p film_to_oleg("Yumpon' Yiminy!")