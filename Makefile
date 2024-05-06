# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: passunca <passunca@student.42porto.com>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/19 15:31:11 by passunca          #+#    #+#              #
#    Updated: 2024/04/19 15:49:01 by passunca         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#==============================================================================#
#                                  MAKE CONFIG                                 #
#==============================================================================#

SHELL := bash

#==============================================================================#
#                                     NAMES                                    #
#==============================================================================#

USER			= passunca
NAME			= randgen
UNAME 			= $(shell uname)

_SUCCESS 		= [$(GRN)SUCCESS$(D)]

#==============================================================================#
#                                    PATHS                                     #
#==============================================================================#

SRC_PATH	= src
LIBS_PATH	= lib
BUILD_PATH	= .build

SRC			= $(addprefix $(SRC_PATH)/, randgen.c)
OBJS		= $(SRC:$(PCG_C_PATH)/%.c=$(BUILD_PATH)/%.o)

LIBFT_PATH	= $(LIBS_PATH)/libft
LIBFT_ARC	= $(LIBFT_PATH)/libft.a

PCG_C_PATH	= $(LIBS_PATH)/pcg-c
PCG_C_ARC	= $(PCG_C_PATH)/src/libpcg_random.a

#==============================================================================#
#                              COMPILER & FLAGS                                #
#==============================================================================#

CC		= cc

CFLAGS		= -Wall -Werror -Wextra
DFLAGS		= -g

#==============================================================================#
#                                COMMANDS                                      #
#==============================================================================#

AR			= ar rcs
RM			= rm -rf
MKDIR_P		= mkdir -p

MAKE		= make -C

#==============================================================================#
#                                  RULES                                       #
#==============================================================================#

##@ Random Number Generator Compilation Rules 🏗

all: deps $(NAME)		## Compile Random Number Generator

$(BUILD_PATH)/%.o: $(SRC_PATH)/%.c
	@echo -n "$(MAG)█$(D)"
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_PATH):
	$(MKDIR_P) $(BUILD_PATH)
	@echo "* $(YEL)Creating $(BUILD_PATH) folder:$(D) $(_SUCCESS)"

$(NAME): $(BUILD_PATH) $(LIBFT_ARC) $(PCG_C_ARC) $(OBJS)
	@echo "[$(YEL)Compiling Random Number Generator$(D)]"
	$(CC) $(CFLAGS) $(DFLAGS) $(OBJS) $(LIBFT_ARC) $(PCG_C_ARC) -o $(NAME)
	@echo "[$(_SUCCESS) compiling $(MAG)Random Number Generator!$(D) $(YEL)🖔$(D)]"

$(LIBFT_ARC):
	$(MAKE) $(LIBFT_PATH) extra

$(PCG_C_ARC):
	$(MAKE) $(PCG_C_PATH)

deps: 			## Download/Update libft
	@if test ! -d "$(LIBFT_PATH)"; then make get_libft; \
		else echo "$(YEL)[libft]$(D) folder found 🖔"; fi
	@if test ! -d "$(PCG_C_PATH)"; then make get_pcgc; \
		else echo "$(YEL)[pcg-c]$(D) folder found 🖔"; fi
	@echo " $(RED)$(D) [$(GRN)Nothing to be done!$(D)]"

get_libft:
	@echo "* $(CYA)Getting Libft submodule$(D)]"
	git clone git@github.com:PedroZappa/42_libft.git $(LIBFT_PATH)
	@echo "* $(GRN)Libft submodule download$(D): $(_SUCCESS)"

get_pcgc:
	@echo "[Downloading $(CYA)Random Number Generator$(D) $(MAG)pcg-c$(D)]"
	git clone git@github.com:imneme/pcg-c.git $(PCG_C_PATH)
	@echo "* $(MAG)pcg-c$(D) download: $(_SUCCESS)"
	@echo "[$(YEL)Building $(MAG)pcg-c$(D) Random Number Generator$(D)]"
	$(MAKE) $(PCG_C_PATH)
	@echo "[$(_SUCCESS) building $(MAG)pcg-c$(D) $(CYA)Random Number Generator!$(D) $(YEL)🖔$(D)]"

##@ Clean-up Rules 󰃢

clean: 				## Remove object files
	$(MAKE) $(LIBFT_PATH) clean
	@echo "* $(YEL)Cleaning build objects 󰃢:$(D) $(_SUCCESS)"
	$(RM) $(BUILD_PATH)
	@echo "* $(YEL)Removing $(CYA)$(BUILD_PATH)$(D) folder & files$(D): $(_SUCCESS)"

fclean: clean	## Remove archives & executables
	$(RM) $(NAME) $(NAME_BONUS)
	@echo "* $(YEL)Cleaning executable$(D): $(_SUCCESS)"
	$(MAKE) $(LIBFT_PATH) fclean

libclean: fclean	## Remove libft
	$(RM) $(LIBS_PATH)
	@echo "* $(YEL)Removing lib folder & files!$(D) : $(_SUCCESS)"

re: fclean all	## Purge and Recompile

#==============================================================================#
#                                  UTILS                                       #
#==============================================================================#

# Colors
#
# Run the following command to get list of available colors
# bash -c 'for c in {0..255}; do tput setaf $c; tput setaf $c | cat -v; echo =$c; done'
#
B  		= $(shell tput bold)
BLA		= $(shell tput setaf 0)
RED		= $(shell tput setaf 1)
GRN		= $(shell tput setaf 2)
YEL		= $(shell tput setaf 3)
BLU		= $(shell tput setaf 4)
MAG		= $(shell tput setaf 5)
CYA		= $(shell tput setaf 6)
WHI		= $(shell tput setaf 7)
GRE		= $(shell tput setaf 8)
BRED 	= $(shell tput setaf 9)
BGRN	= $(shell tput setaf 10)
BYEL	= $(shell tput setaf 11)
BBLU	= $(shell tput setaf 12)
BMAG	= $(shell tput setaf 13)
BCYA	= $(shell tput setaf 14)
BWHI	= $(shell tput setaf 15)
D 		= $(shell tput sgr0)
BEL 	= $(shell tput bel)
CLR 	= $(shell tput el 1)
