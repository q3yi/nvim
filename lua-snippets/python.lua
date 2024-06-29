-- customized python snippets
---@diagnostic disable: undefined-global
local M = {}

local leetcode = s(
    {
        trig = "leetcode",
        dscr = "leetcode solution py file template with unittest.",
    },

    fmt(
        [[
              import unittest
              from typing import {types}


              class Solution:

                  def {func}(self, {args}) -> {return_type}:
                      pass


              class TestSolution(unittest.TestCase):
                  def _run_test(self, test_f):
                      test_cases = [
                          {test_cases}
                      ]

                  def test_{func_rep_1}(self):
                      s = Solution()
                      self._run_test(s.{func_rep_2})
            ]],
        {
            types = i(1, "T"),
            func = i(2, "func"),
            args = i(3, "args"),
            return_type = i(4, "return_type"),
            test_cases = i(0),
            func_rep_1 = rep(2),
            func_rep_2 = rep(2),
        }
    )
)
table.insert(M, leetcode)

return M
