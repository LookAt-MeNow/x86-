void swap(int *a,int *b){
    int x = *a;
    *a = *b;
    *b = x;
}
int main(){
    int a = 3;
    int b = 4;
    swap(&a,&b);
}
