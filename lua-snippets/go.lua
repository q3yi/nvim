-- customized go snippets

local M = {}

local leetcode = s(
    {
        trig = "ltest",
        dscr = "leetcode solution unittest template.",
    },

    fmt(
        [[
            import "testing"
            
            func Test<func>(t *testing.T) {
            	testcases := []struct {
            		<case_struct>
            	}{
            		<test_cases>
            	}
            
            	for _, cs := range testcases {
            		<test_body>
            	}
            }
        ]],
        {
            func = i(1, "Func"),
            case_struct = i(2, ""),
            test_cases = i(3, ""),
            test_body = i(0),
        },
        {
            delimiters = "<>",
        }
    )
)

table.insert(M, leetcode)

return M
