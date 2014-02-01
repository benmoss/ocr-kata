class FileWriter
  def initialize(file:, account:)
    self.file = file
    self.account = account
  end

  def write
    file.write(account.value)
    if account.errors
      file.write(" #{account.errors}")
    end
  end

  private
  attr_accessor :account, :file
end
