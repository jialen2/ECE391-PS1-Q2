/*
 * tab:2
 *
 * search_asm.S - Implementation of Assembly Recursive DFS
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose, without fee, and without written agreement is
 * hereby granted, provided that the above copyright notice and the following
 * two paragraphs appear in all copies of this software.
 *
 * IN NO EVENT SHALL THE AUTHOR OR THE UNIVERSITY OF ILLINOIS BE LIABLE TO
 * ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
 * DAMAGES ARISING OUT  OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION,
 * EVEN IF THE AUTHOR AND/OR THE UNIVERSITY OF ILLINOIS HAS BEEN ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * THE AUTHOR AND THE UNIVERSITY OF ILLINOIS SPECIFICALLY DISCLAIM ANY
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
 * PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND NEITHER THE AUTHOR NOR
 * THE UNIVERSITY OF ILLINOIS HAS ANY OBLIGATION TO PROVIDE MAINTENANCE,
 * SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
 *
 * Author:        Aamir Hasan
 * Version:       1
 * Creation Date: Fri Aug 30 2020
 * Filename:      search_asm.S
 * History:
 *    AS    1    Fri Aug 30 2020
 *        First written.
 */

.global binarySearch_asm

# Search ASM (Assembly)
# Searches for an element in a BST
# Declaration is in search.h
#
# Registers:
#   eax - Return Value
# 
binarySearch_asm:
  pushl %ebp
  movl %esp, %ebp
  # Callee-saved registers
  pushl %ebx
  pushl %esi
  pushl %edi
  pushl %edx
  # mid = ebx = 0
  andl $0, %ebx
  # low = esi
  movl 16(%ebp), %esi
  # high = edi
  movl 20(%ebp), %edi

  # -if (low <= high)
  cmpl %edi, %esi
  jg finish
  # mid = (low + high) / 2
  andl $0, %eax
  addl %esi, %eax
  addl %edi, %eax
  andl $0, %edx
  movl $2, %ecx
  div %ecx
  movl %eax, %ebx

  # arr = edx
  movl 8(%ebp), %edx
  # arr[mid] = eax
  movl 0(%edx, %ebx, 4), %eax
  # md = ecx
  movl 12(%ebp), %ecx
  cmpl %eax, %ecx
  je find_value
  jl search_left
  jmp search_right


find_value:
  movl $1, %eax
  jmp return
  
search_left:
  # Push parameters
  movl %ebx, %eax
  subl $1, %eax
  pushl %eax
  pushl %esi
  pushl %ecx
  pushl %edx
  call binarySearch_asm
  addl $16, %esp
  jmp return

search_right:
  # Push parameters
  pushl %edi
  movl %ebx, %edi
  addl $1, %edi
  pushl %edi
  pushl %ecx
  pushl %edx
  call binarySearch_asm
  addl $16, %esp
  jmp return

return:
  popl %edx
  popl %edi
  popl %esi
  popl %ebx
  leave
  ret
  

finish:
  movl $1, %eax
  neg %eax
  jmp return
