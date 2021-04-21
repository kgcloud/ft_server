# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: canjugun <canjugun@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/19 17:56:17 by canjugun          #+#    #+#              #
#    Updated: 2021/04/21 11:37:05 by canjugun         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

docker build -t ft_server . 
docker run --rm --name ft_server -d -p 80:80 -p 443:443 ft_server
# docker run --env AUTOINDEX=off --name ft_server -d -p 443:443 -p 80:80 ft_server
docker exec -it ft_server bash