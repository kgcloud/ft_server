# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    del.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: canjugun <canjugun@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/04/21 11:36:05 by canjugun          #+#    #+#              #
#    Updated: 2021/04/21 11:36:26 by canjugun         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

docker stop ft_server
docker rm $(docker ps -qa)
docker system prune --force
