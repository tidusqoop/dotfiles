return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local lint = require("lint")
      local linter = lint.linters.golangcilint
      local original_args = linter.args

      -- nvim-lint의 golangcilint는 go env GOMOD만 확인하여
      -- go.work 워크스페이스에서 파일 단위 분석으로 잘못 전환됨.
      -- GOWORK가 설정된 경우 디렉토리 경로(:h)를 사용하도록 마지막 인자만 교체.
      if original_args and #original_args > 0 then
        original_args[#original_args] = function()
          local gowork = vim.fn.system({ "go", "env", "GOWORK" }):gsub("%s+", "")
          if gowork ~= "" and gowork ~= "/dev/null" then
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
          end
          -- go.work가 없으면 nvim-lint 원본 로직 유지
          local gomod = vim.fn.system({ "go", "env", "GOMOD" }):gsub("%s+", "")
          if gomod == "/dev/null" or gomod == "" then
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
          end
          return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
        end
      end
    end,
  },
}
