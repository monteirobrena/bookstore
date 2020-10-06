publisher_hogarth = PublishingHouse.create(name: "Hogarth Press", discount: 50)
publisher_penguin = PublishingHouse.create(name: "Penguin Random House", discount: 40)

author_simone   = Author.create(name: "Simone Beauvoir", bio: "Simone Lucie Ernestine Marie Bertrand Beauvoir (9 January 1908 – 14 April 1986) was a French writer, intellectual, existentialist philosopher, political activist, feminist and social theorist ")
author_alain    = Author.create(name: "Alain de Botton", bio: "Alain de Botton (born 20 December 1969) is a Swiss-born British philosopher and author. His books discuss various contemporary subjects and themes, emphasizing philosophy's relevance to everyday life.")
author_virginia = Author.create(name: "Virginia Wolf",   bio: "Adeline Virginia Woolf (25 January 1882 – 28 March 1941) was an English writer, considered one of the most important modernist 20th century authors and also a pioneer in the use of stream of consciousness as a narrative device.")
author_jostein  = Author.create(name: "Jostein Gaarder", bio: "Jostein Gaarder (born 8 August 1952) is a Norwegian intellectual and author of several novels, short stories and children's books. Gaarder often writes from the perspective of children, exploring their sense of wonder about the world.")

Book.create(title: "Jacob's Room", author: author_virginia, publisher: publisher_hogarth, price: 24.20)
Book.create(title: "The Voyage Out", author: author_virginia, publisher: publisher_hogarth, price: 54.99)

Book.create(title: "The News: A User's Manual", author: author_alain, publisher: publisher_penguin, price: 29.00)
Book.create(title: "The Architecture of Happiness", author: author_alain, publisher: publisher_penguin, price: 65.99)

Book.create(title: "The Coming of Age", author: author_virginia, publisher: publisher_penguin, price: 44.99)
Book.create(title: "The Woman Destroyed", author: author_virginia, publisher: publisher_penguin, price: 19.95)

Book.create(title: "Sophie's World", author: author_jostein, publisher: publisher_penguin, price: 19.95)
Book.create(title: "The Christmas Mystery", author: author_jostein, publisher: publisher_penguin, price: 19.95)

