''
  -- Configure nvim-jdtls
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      local jdtls = require('jdtls')
      local root_markers = {'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}
      local root_dir = require('jdtls.setup').find_root(root_markers)
      local home = os.getenv('HOME')

      -- Define the command to start the jdtls language server
      local config = {
        cmd = {
          "java", -- or the path to your java binary
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xms1g",
          "-Xmx2G",
        },
        root_dir = root_dir,
        settings = {
          java = {
            format = {
              enabled = true,
            },
          },
        },
        init_options = {
          bundles = {},
        },
      }

      -- Start or attach the jdtls language server with the given configuration
      jdtls.start_or_attach(config)
    end
  })
''
