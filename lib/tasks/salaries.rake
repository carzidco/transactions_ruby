namespace :salaries do

  desc "deposit/withdrawal"
  task :deposit_withdrawal, [:amount] => :environment do |t, args|
    amount = args[:amount].to_f
    Budget.transaction do
      begin
        Account.all.each do |a|
          a[:salary] += amount
          a.save!
          b = Budget.new(:amount => amount*-1)
          b.save!
          raise "We're broken bro!!" if total_budget <= 0 
        end
      rescue => e
        binding.pry
        raise ActiveRecord::Rollback
      end
    end
  end

  desc "Deposit to budget"
  task :deposit_budget, [:amount] => :environment do |t, args|
      amount = args[:amount].to_f
      raise "Non negative" if amount <= 0
      b = Budget.new(:amount => amount)
      b.save!
  end

  def total_budget
    Budget.sum(:amount)
  end

end
