NAME = get_next_line.a

CC = cc
INCDIR = -I. -I./bonus
CFLAGS = -Wall -Wextra -Werror -D BUFFER_SIZE=42 $(INCDIR)

MANDATORY = get_next_line.c  get_next_line_utils.c
BONUS = get_next_line_bonus.c  get_next_line_utils_bonus.c
TEST = main.c

SRCS = $(MANDATORY)
B_SRCS = $(addprefix bonus/,$(BONUS))
T_SRC = $(TEST)

OBJS = $(SRCS:%.c=%.o)
B_OBJS = $(B_SRCS:%.c=%.o)
T_OBJ = $(T_SRC:%.c=%.o)

ifdef WITH_BONUS
	OBJS += $(B_OBJS)
endif

$(NAME): $(OBJS)
		ar -rcs $(NAME) $(OBJS)

all: $(NAME)

bonus:
		@make all WITH_BONUS=1

clean:
		$(RM) $(OBJS) $(B_OBJS)

fclean: clean
		$(RM) $(NAME)

re: fclean all

test:
		$(CC) $(CFLAGS) $(SRCS) $(T_SRC)
		@./a.out

norm:
		@norminette -R CheckDefine *.h
		@norminette -R CheckForbiddenSourceHeader $(SRCS) $(B_SRCS)

.PHONY: all clean fclean re bonus norm test
