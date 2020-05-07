from tkinter import *
from tkinter import messagebox
import random
import copy
import time

# state cuối cùng mà agent cần đạt được để kết thúc bài toán
# các vị trí được lưu dưới dạng string, có thứ tự sắp xếp từ trái qua phải, từ trên xuống dưới
# đây là biến mà ta sẽ dùng để so sánh xem state hiện tại của puzzle có phải là goal hay không
_goal_state = '012345678'

# trạng thái sắp xếp ban đầu của bài toán, do chương trình quy ước sẵn
_init_state = '724506831'

# với mỗi ô sẽ có những ô lân cận thích hợp, tùy thuộc vào vị trí
# được lưu dưới dạng dict, key-value pairs
_neighbors = {0: [1,3],
              1: [0,2,4],
              2: [1,5],
              3: [0,4,6],
              4: [1,3,5,7],
              5: [2,4,8],
              6: [3,7],
              7: [4,6,8],
              8: [5,7]}

# loại thuật toán được sử dụng để giải puzzle
_algo = {1:"Iterative Deepening Search"}

class EightPuzzle(object):

    #class được tạo ra gồm thuộc tính state, [object] là đối tượng khởi tạo theo mẫu 
    def __init__(self, input_state=None):
        
        # input_state=None ý nói giá trị default của state ban đầu là rỗng
        # nếu người dùng tạo object thuộc kiểu EightPuzzle mà truyền tham số không rỗng thì tham số đó sẽ được gán vào input_state


        if input_state:     # câu này ý nói if input_state is not null -> gán nó vô thuộc tính state của EightPuzzle
            self.state = copy.deepcopy(input_state)
        else:       
            # nếu người dùng tạo object thuộc kiểu EightPuzzle với tham số rỗng
            self.state = copy.deepcopy(_goal_state)     # chương trình sẽ gán đại trạng thái goal vào thuộc tính state
            self.shuffle()                              # sau đó chương trình random một trạng thái bất kỳ cho puzzle
            

    # shuffle the current state
    # shuffle trạng thái hiện tại
    def shuffle(self):
        pos0 = self.state.index('0')        # gán vị trí hiện tại của ô chữ 0 vào biến pos0
        for i in range(100):
            # gán những ô hàng xóm với vị trí của chữ 0 thành danh sách vào biến choices
            choices = _neighbors[pos0] 
            # random vị trí một ô bất kỳ là hàng xóm với chữ số 0, lấy từ list choices, gán tạm thời vào pos 
            pos = choices[random.randint(0, len(choices)-1)]
            self.swap(pos)
            pos0 = self.state.index('0') # lấy vị trí của chữ 0 sau khi tráo
            # lặp lại 100 lần

    # swap 0 with its neighbor pos
    # tráo vị trí chữ số 0 với vị trí pos
    def swap(self, pos):
        pos0 = self.state.index('0')
        l = list(self.state)
        l[pos0], l[pos] = l[pos], l[pos0]
        self.state = ''.join(l)

    # get all the possible next states
    # tìm tất cả những nước đi có thể với vị trí hiện tại
    def get_next(self, current):
        pos0 = current.index('0')
        nextStates = []

        # lượt qua danh sách những ô là hàng xóm của số 0, xét từng ô
        # chương trình hoán vị trí của mỗi ô hàng xóm với ô chữ 0, và lưu lại trạng thái của puzzle vào biến list nextStates,
        # được tính là một nước đi
        for pos in _neighbors[pos0]: 
            l = list(current)
            l[pos0], l[pos] = l[pos], l[pos0]
            step = ''.join(l)
            nextStates.append(step)
        return nextStates  

    # Iterative Deepening search algorithm
    def solve_by_IDS(self):

        # DFS with depth limit
        def explore(current, depth):
            nonlocal goal, solved, limit
            if current == goal:
                solved = True
                return
            if depth >= limit:
                return
            next_depth = depth+1
            for next_node in self.get_next(current):    # tìm tất cả nước đi tiếp theo của trạng thái hiện tại và chạy vòng lặp
                if not next_node in visited:        # nếu vị trí hiện tại chưa từng đi qua
                    visited[next_node] = True       # bật cờ visited thành true (đã đi qua)
                    previous[next_node] = current
                    if not next_depth in level:
                        level[next_depth] = []
                    level[next_depth].append(next_node) # sau khi duyệt xong, khởi tạo level tiếp theo
                    explore(next_node, next_depth)       # gọi hàm recursive explore(node tiếp theo cần duyệt, depth cũ + 1)
                if solved:
                    break
        

        root = self.state # gán trạng thái hiện tại của puzzle vào root
        goal = '012345678'
        previous = {root: None}
        visited = {root: True}
        level = {0:[root]}
        solved = (root == goal)
        limit = 0

        # bắt đầu chạy vòng lặp tìm đường đi
        # while cờ solved vẫn còn false (chưa tìm được lời giải) 
        # và level mình đang xử lý hiện tại còn nằm trong mức limit đang xét
        # ý là mình sẽ khám phá từng level, hết vòng lặp thì sẽ tăng limit lên 1, chạy đến khi hàm explore(current, depth)
        # đổi biến solved thành true thì thôi
        while not solved and limit in level:
            depth = limit
            limit += 1
            for node in level[depth]:
                explore(node, depth)

        if solved:
            ###
            print(self.retrieve_path(goal, previous))
            return self.retrieve_path(goal, previous), len(visited)
        return None, len(visited)

    # tìm đường đi ngắn nhất
    def retrieve_path(self, goal, previous):
        path = [goal]       # path là list từ 0 đến 8
        current = goal      # current là goal state
        while previous[current]:    # nếu trong danh sách previous có tồn tại 
            path.insert(0, previous[current]) #thêm state (previous) vào đường đi path
            current = previous[current] #chuyển đến trạng thái tiếp theo
        return path

puzzle = EightPuzzle(_init_state)

# biểu diện lên màn hình trạng thái hiện tại của các ô trong bài toán
def display():
    color = 'gray' if puzzle.state != _goal_state else 'green'

    for i in range(9):
        if puzzle.state[i] != '0':
            var[i].set(str(puzzle.state[i]))
            label[i].config(bg=color)
        else:
            var[i].set('')
            label[i].config(bg='white')

# hàm giải bài toán
def solve():
    for b in button:
        b.configure(state='disabled')
    option.configure(state='disabled')

    temp = select.get()
    index = 1
    for k,e in _algo.items():
        if e == temp:
            index = k
            break
    
    print('Solving...')
    
    # get solving time
    stime = time.time()                 # tính toán thời gian giải
    path, n = puzzle.solve_by_IDS()     #### CHẠY THUẬT TOÁN TÌM CÁCH GIẢI
    ttime = time.time()

    # nếu bài toán không thể giải được
    if not path:    
        print('This 8-puzzle is unsolvable!')
        for i in range(9):
            label[i].config(bg='red' if puzzle.state[i] != '0' else 'white')
        for b in button:
            b.configure(state='normal')
        option.configure(state='normal')
        return

    info = 'Algorithm: '+_algo[index]+'\n' \
         + 'Time: '+str(round(ttime-stime, 6))+'s\n' \
         + 'States Explored: '+str(n)+'\n' \
         + 'Shortest Path: '+str(len(path)-1)+' steps.'
    print(info)
    display_procedure(path) 

# demonstrate the shortest path
# hiển thị kết quả bài toán
def display_procedure(path):
    if not path:                # nếu bài toán không giải được
        for b in button:
            b.configure(state='normal')
        option.configure(state='normal')
        return
    puzzle.state = path.pop(0) # xóa trạng thái đầu tiên trong lời giải (path)
    display() # hiện ra màn hình nước đi
    win.after(500, lambda: display_procedure(path)) # gọi hàm recursive display_procedure 
                                                    # để thực hiện bước đi tiếp theo trong hàng đợi path

# shuffle the state
def shuffle():
    puzzle.shuffle()
    display()

# reset to the initial state
def reset():
    puzzle.state = copy.deepcopy(_init_state)
    display()



#
# Set up of Basic UI
#
win = Tk()
win.geometry('+300+100')
win.title('8-Puzzle')
algoFrame = Frame(win, width=260, relief=RAISED)
algoFrame.pack()
select = StringVar(algoFrame)
select.set(_algo[1]) # default value
option = OptionMenu(algoFrame, select, _algo[1])
option.pack()
board = Frame(win, width=260, height=260, relief=RAISED)
board.pack()
var = [StringVar() for i in range(9)]
label = [Label(board, textvariable=var[i], bg='gray', font=('Calibri', 48)) for i in range(9)]
for i in range(3):
    for j in range(3):
        label[i*3+j].place(x=85*j+5,y=85*i+5, width=80, height=80)
        
buttonFrame = Frame(win, relief=RAISED, borderwidth=1)
buttonFrame.pack(fill=X, expand=True)
button = []
button.append(Button(buttonFrame, width='8', relief=RAISED, text="Reset", command=reset))
button.append(Button(buttonFrame, width='8', relief=RAISED, text="Shuffle", command=shuffle))
button.append(Button(buttonFrame, width='8', relief=RAISED, text="Solve", command=solve)) # to be initialized
for b in button:
    b.pack(side=LEFT, padx=5, pady=7)
   


# initialization of the game
def main():
    display()
    win.mainloop()

if __name__ == "__main__":
    main()
