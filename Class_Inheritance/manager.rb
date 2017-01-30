require_relative 'employee'

class Manager < Employee

  def initialize(employees, name, title, salary, boss)
    @employees = employees
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    sum = 0
    @employees.each do |employee|
      sum += employee.bonus(multiplier)
      sum += employee.salary * multiplier if employee.is_a? Manager
    end
    sum
  end

end

if __FILE__ == $0
  david = Employee.new("David", "TA", 10_000, "Darren")
  shawna = Employee.new("Shawna", "TA", 12_000, "Darren")
  darren = Manager.new([david, shawna], "Darren", "TA Manager", 78_000, "Ned")
  ned = Manager.new([darren], "Ned", "Founder", 1_000_000, nil)

  puts ned.bonus(5)
  puts darren.bonus(4) # => 88_000
  puts david.bonus(3) # => 30_000
end
