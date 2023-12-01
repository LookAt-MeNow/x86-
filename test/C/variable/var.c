int main(){
    int a[2] = {1, 2};
    int x = a[0];
    int y = a[1];
    asm("movl $11, -8(%rbp)");
    int z = a[2];
    while(1);
}